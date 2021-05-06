class Quality::RejectTagMailer < ApplicationMailer

  helper :application

  def notification_email
    @reject_tag = params[:reject_tag]
    # @reject_tag.attachments.each do |attachment|
    #   attachments[attachment.name] = {
    #     mime_type: attachment.file.content_type,
    #     content: attachment.file.download
    #   }
    # end
    mail  to: "toby.varland@varland.com",
          subject: "Reject Tag #{@reject_tag.description} (#{@reject_tag.shop_order.part_spec.join(", ")})"
  end

end