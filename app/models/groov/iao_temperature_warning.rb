class Groov::IAOTemperatureWarning < Groov::Log

  # Instance methods.

  # Notification settings.
  def notification_settings
    return {
      enabled: true,
      subject: "#{self.controller_name}: #{self.device} IAO Temperature Out of Range",
      recipients: [TOBY_VARLAND_EMAIL]
    }
  end

  # Log details.
  def details
		return "<p>Temperature out of range.</p><p><small>IAO:</small> <code>#{self.device}</code><br>Reading: <code>#{self.reading}º F</code><br>Low limit: <code>#{self.low_limit}º F</code><br>High limit: <code>#{self.high_limit}º F</code></p>"
  end

  # Returns human readable log type.
  def log_type
    return "IAO Temperature Out of Range"
  end

end