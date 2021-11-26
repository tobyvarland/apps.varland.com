class Groov::AuthenticationError < Groov::Log

  # Instance methods.

  # Notification settings.
  def notification_settings
    return {
      enabled: true,
      subject: "#{self.controller_name}: Nitrogen Pack Swapped",
      recipients: [TOBY_VARLAND_EMAIL]
    }
  end

  # Log details.
  def details
		user_string = nil
    if self.user.present?
			user_string = " by #{self.user.name}"
    end
		return "<p>#{self.device} swapped#{user_string}. PSI before swap: <code>#{self.groov_data[:start_psi]} PSI</code>. PSI after swap: <code>#{self.groov_data[:end_psi]} PSI</code>.</p>"
  end

end