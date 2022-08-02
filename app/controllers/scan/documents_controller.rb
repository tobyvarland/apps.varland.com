class Scan::DocumentsController < ApplicationController

  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!

  def index
    begin
      @pagy, @scan_documents = pagy(Scan::Document.order(created_at: :desc), items: 100)
    rescue
      @pagy, @scan_documents = pagy(Scan::Document.order(created_at: :desc), items: 100, page: 1)
    end
  end

  def show
    @scan_document = Scan::Document.find(params[:id])
    send_data(@scan_document.scanned_file.download,
              filename: "document.pdf",
              type: "application/pdf",
              disposition: "inline")
  end

  def convert_to_shop_order
    @scan_document = Scan::Document.find(params[:id])
    file = Tempfile.new("file#{Time.now}")
    file.binmode
    file << @scan_document.scanned_file.blob.download
    file.close
    Scan::ShopOrder.with_shop_order(params[:shop_order][:number]).each do |old|
      old.scanned_file.purge
      old.destroy
    end
    @scan_shop_order = Scan::ShopOrder.new
    @scan_shop_order.shop_order_number = params[:shop_order][:number]
    @scan_shop_order.contents = extract_pdf_contents(file.path)
    @scan_shop_order.scanned_file.attach(io: File.open(file.path), filename: @scan_document.scanned_file.blob.filename.to_s, content_type: 'application/pdf')
    file.unlink
    if @scan_shop_order.save
      @scan_document.scanned_file.purge
      @scan_document.destroy
      redirect_back fallback_location: scan_documents_url, notice: "Scanned document successfully converted to shop order."
    else
      redirect_back fallback_location: scan_documents_url, alert: "Failed to convert scanned document to shop order. Contact IT for help."
    end
  end

  def create
    classification = analyze_uploaded_file(params[:scan_document][:scanned_file].path)
    case classification[:type]
    when :shop_order
      @scan_document = Scan::ShopOrder.new(scan_document_params)
      @scan_document.shop_order_number = classification[:number]
      @scan_document.contents = classification[:contents]
    else
      @scan_document = Scan::Document.new(scan_document_params)
    end
    if @scan_document.save
      return head :created
    else
      return head :unprocessable_entity
    end
  end

private

  def extract_pdf_contents(path)
    pdf = Poppler::Document.new(path)
    return pdf.map { |page| page.get_text }.join
  end

  def analyze_uploaded_file(path)

    # Initialize PDF type.
    type_info = { type: :generic }

    # Extract text.
    contents = extract_pdf_contents(path)

    # Classify document.
    should_delete = false
    so_regex = /VMS(\d{6})/
    if contents.match?(so_regex)
      match_data = contents.match(so_regex)
      shop_order_number = match_data[1].to_i
      Scan::ShopOrder.with_shop_order(shop_order_number).each do |old|
        old.scanned_file.purge
        old.destroy
      end
      type_info = { type: :shop_order, number: shop_order_number, contents: contents }
    end

    # Return classification info.
    return type_info

  end

  def scan_document_params
    params.require(:scan_document).permit(:scanned_file)
  end

end