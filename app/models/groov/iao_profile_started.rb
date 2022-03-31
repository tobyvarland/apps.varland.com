class Groov::IAOProfileStarted < Groov::Log

  # Instance methods.

  # Notification settings.
  def notification_settings
    return {
      enabled: true,
      subject: "#{self.controller_name}: #{self.device} IAO Profile Started",
      recipients: [TOBY_VARLAND_EMAIL]
    }
  end

  # Log details.
  def details
		return "<p>IAO profile started.</p><p><small>IAO:</small> <code>#{self.device}</code></p>"
  end

  # Returns human readable log type.
  def log_type
    return "IAO Profile Started"
  end

end