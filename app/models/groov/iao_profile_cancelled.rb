class Groov::IAOProfileCancelled < Groov::Log

  # Instance methods.

  # Notification settings.
  def notification_settings
    return {
      enabled: true,
      subject: "#{self.controller_name}: #{self.device} Profile Cancelled by User",
      recipients: [TOBY_VARLAND_EMAIL]
    }
  end

  # Log details.
  def details
		return "<p>Profile cancelled by user.</p><p><small>IAO:</small> <code>#{self.device}</code><br><small>Cancelled By:</small> <code>#{self.groov_user}</code><br><small>Reason:</small> <code>#{self.groov_data[:reason]}</code></p>"
  end

  # Returns human readable log type.
  def log_type
    return "IAO Profile Cancelled"
  end

end