class Groov::IAOPressureWarning < Groov::Log

  # Instance methods.

  # Notification settings.
  def notification_settings
    return {
      enabled: true,
      subject: "#{self.controller_name}: #{self.device} IAO Chamber Pressure Out of Range",
      recipients: [TOBY_VARLAND_EMAIL]
    }
  end

  # Log details.
  def details
		return "<p>Chamber pressure out of range.</p><p><small>IAO:</small> <code>#{self.device}</code><br>Reading: <code>#{self.reading} IWC</code><br>Low limit: <code>#{self.low_limit} IWC</code><br>High limit: <code>#{self.high_limit} IWC</code></p>"
  end

  # Returns human readable log type.
  def log_type
    return "IAO Chamber Pressure Out of Range"
  end

end