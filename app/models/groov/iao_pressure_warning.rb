class Groov::IaoPressureWarning < Groov::Log

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
		return "<p>Chamber pressure out of range. IAO: <code>#{self.device}</code>. Reading: <code>#{self.reading} IWC</code>. Low limit: <code>#{self.low_limit} IWC</code>. High limit: <code>#{self.high_limit} IWC</code>.</p>"
  end

  # Returns human readable log type.
  def log_type
    return "IAO Chamber Pressure Out of Range"
  end

end