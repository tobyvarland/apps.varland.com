class ShippingMailer < ApplicationMailer

  helper :application

  def receiving_priority_note_completion_email
    @note = params[:note]
    mail  to: @note.requested_by_user.email,
          subject: "Receiving Priority Note Marked Complete"
  end

end