class Shipping::ReceivingPriorityNoteMailer < ApplicationMailer

  helper :application

  def completion_email
    @note = params[:note]
    mail  to: @note.requested_by_user.email,
          subject: "Receiving Priority Note Marked Complete"
  end

end