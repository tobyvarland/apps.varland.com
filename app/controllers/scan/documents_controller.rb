class Scan::DocumentsController < ApplicationController

  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!

  def create
    @scan_document = Scan::Document.new(scan_document_params)
    if @scan_document.save
      Scan::AnalyzeScannedFileJob.perform_later(@scan_document.id)
      return head :created
    else
      return head :unprocessable_entity
    end
  end

private

  def scan_document_params
    params.require(:scan_document).permit(:scanned_file)
  end

end