class ShippingMailer < ApplicationMailer

  helper :application

  def receiving_priority_note_completion_email
    @note = params[:note]
    mail  to: email_address_with_name(@note.requested_by_user.email, @note.requested_by_user.name),
          subject: "Receiving Priority Note Marked Complete"
  end

end