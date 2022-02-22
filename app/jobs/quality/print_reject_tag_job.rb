class Quality::PrintRejectTagJob < ApplicationJob

  queue_as :default

  def perform(reject_tag, first_page_printer, other_pages_printer)

    # Generate PDF file.
    path = Rails.root.join('tmp', 'pdfs', "#{reject_tag.description}.pdf")
    pdf = Quality::RejectTagPdf.new(reject_tag)
    pdf_file = File.open path, "wb"
    pdf_file.write pdf.render
    pdf_file.close

    # Call command to print file.
    first_page_command = "lpr -P #{first_page_printer} -o page-ranges=1 #{path}"
    system(first_page_command)
    if reject_tag.attachments.length > 0
      1.upto(reject_tag.attachments.length) do |i|
        attachments_command = "lpr -P #{other_pages_printer} -o page-ranges=#{i + 1} #{path}"
        system(attachments_command)
      end
    end

    # Delete PDF file.
    File.delete(path)

    # Print partial tag if flag set.
    if reject_tag.print_partial_tag

      # Generate PDF.
      path = Rails.root.join('tmp', 'pdfs', "#{reject_tag.description}-Partial.pdf")
      pdf = Quality::RejectTagPartialTagPdf.new(reject_tag.shop_order)
      pdf_file = File.open path, "wb"
      pdf_file.write pdf.render
      pdf_file.close

      # Print file.
      partial_tag_command = "lpr -P #{other_pages_printer} #{path}"
      system(partial_tag_command)

      # Delete PDF file.
      File.delete(path)

      # Clear flag.
      #reject_tag.print_partial_tag = false
      #reject_tag.save

    end

  end

end