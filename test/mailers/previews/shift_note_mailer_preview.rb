# Preview all emails at http://localhost:3000/rails/mailers/shift_note_mailer
class ShiftNoteMailerPreview < ActionMailer::Preview

  def notification_email
    ShiftNoteMailer.with(shift_note: ShiftNote.last).notification_email
  end

end