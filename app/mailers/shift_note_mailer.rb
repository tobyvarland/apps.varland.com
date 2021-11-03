class ShiftNoteMailer < ApplicationMailer

  helper :application

  def notification_email
    @shift_note = params[:shift_note]
    @shift_note.attachments.each do |attachment|
      attachments[attachment.name] = {
        mime_type: attachment.file.content_type,
        content: attachment.file.download
      }
    end
    mail  to: "dailyshiftnotes@varland.com",
          subject: "New Shift Note"
  end

end