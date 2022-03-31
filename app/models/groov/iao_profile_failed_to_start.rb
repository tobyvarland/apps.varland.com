class Groov::IAOProfileFailedToStart < Groov::Log

  # Instance methods.

  # Notification settings.
  def notification_settings
    return {
      enabled: true,
      subject: "#{self.controller_name}: #{self.device} IAO Failed to Start",
      recipients: [TOBY_VARLAND_EMAIL]
    }
  end

  # Log details.
  def details
		return "<p>IAO failed to start.</p><p>IAO: <code>#{self.device}</code>.</p>"
  end

  # Returns human readable log type.
  def log_type
    return "IAO Failed to Start"
  end

end