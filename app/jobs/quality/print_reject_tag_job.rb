class Quality::PrintRejectTagJob < ApplicationJob

  queue_as :default

  def perform(reject_tag, first_page_printer, other_pages_printer)

    #puts "🔴 Printing reject tag..."

    # Generate PDF file.
    path = Rails.root.join('tmp', 'pdfs', "#{reject_tag.description}.pdf")
    pdf = Quality::RejectTagPdf.new(reject_tag)
    pdf_file = File.open path, "wb"
    pdf_file.write pdf.render
    pdf_file.close
    #puts "🔴 Generated reject tag PDF (#{path})"

    # Call command to print file.
    first_page_command = "lpr -P #{first_page_printer} -o page-ranges=1 #{path}"
    system(first_page_command)
    #puts "🔴 Printed first page (#{first_page_command})"
    if reject_tag.attachments.length > 0
      1.upto(reject_tag.attachments.length) do |i|
        attachments_command = "lpr -P #{other_pages_printer} -o page-ranges=#{i + 1} #{path}"
        system(attachments_command)
        #puts "🔴 Printed additional page (#{attachments_command})"
      end
    end

    # Delete PDF file.
    File.delete(path)
    #puts "🔴 Deleted reject tag PDF"

    # Print partial tag if flag set.
    if reject_tag.print_partial_tag

      #puts "🔴 Need to print partial order tag"

      # Generate PDF.
      path = Rails.root.join('tmp', 'pdfs', "#{reject_tag.description}-Partial.pdf")
      pdf = Quality::RejectTagPartialTagPdf.new(reject_tag.shop_order)
      pdf_file = File.open path, "wb"
      pdf_file.write pdf.render
      pdf_file.close
      #puts "🔴 Generated partial order tag PDF (#{path})"

      # Print file.
      partial_tag_command = "lpr -P #{other_pages_printer} #{path}"
      system(partial_tag_command)
      #puts "🔴 Printed partial order tag (#{partial_tag_command})"

      # Delete PDF file.
      File.delete(path)

      # Clear flag.
      #reject_tag.print_partial_tag = false
      #reject_tag.save

    end

  end

end