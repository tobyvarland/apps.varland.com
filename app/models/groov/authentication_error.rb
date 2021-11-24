class Groov::AuthenticationError < Groov::Log

  # Instance methods.

  # Notification settings.
  def notification_settings
    return {
      enabled: true,
      subject: "#{self.controller_name}: Authentication Error",
      recipients: [TOBY_VARLAND_EMAIL]
    }
  end

  # Log details.
  def details
    if self.user.present?
      return "<p>Authentication error for #{self.user.name} (##{self.user.employee_number}).</p>"
    else
      return "<p>Authentication error for ##{self.groov_data[:employee_number]}. Employee number did not match known user.</p>"
    end
  end

end