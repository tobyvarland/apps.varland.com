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
		return "<p>Temperature out of range. IAO: <code>#{self.device}</code>. Reading: <code>#{self.reading}º F</code>. Low limit: <code>#{self.low_limit}º F</code>. High limit: <code>#{self.high_limit}º F</code>.</p>"
  end

  # Returns human readable log type.
  def log_type
    return "IAO Temperature Out of Range"
  end

end