class Scan::AnalyzeScannedFileJob < ApplicationJob

  queue_as :default

  def perform(id)

    # Get reference to scanned document.
    doc = Scan::Document.find(id)

    # Extract text.
    path = ActiveStorage::Blob.service.path_for(doc.scanned_file.blob.key)
    document = Poppler::Document.new(path)
    contents = document.map { |page| page.get_text }.join

    # Classify document.
    should_delete = false
    so_regex = /VMS(\d{6})/
    if contents.match?(so_regex)
      match_data = contents.match(so_regex)
      scan_so = Scan::ShopOrder.new
      scan_so.shop_order_number = match_data[1].to_i
      scan_so.contents = contents
      scan_so.scanned_file.attach(io: File.open(path), filename: doc.scanned_file.blob.filename.to_s, content_type: 'application/pdf')
      should_delete = scan_so.save
    end

    # Delete scanned document if necessary.
    if should_delete
      doc.scanned_file.purge
      doc.destroy
    end

  end

end