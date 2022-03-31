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
		return "<p>Chamber pressure out of range.</p><p><small>IAO:</small> <code>#{self.device}</code><br><small>Reading:</small> <code>#{self.reading.to_f.round(3)} IWC</code><br><small>Low Limit:</small> <code>#{self.low_limit.to_f.round(3)} IWC</code><br><small>High Limit:</small> <code>#{self.high_limit.to_f.round(3)} IWC</code></p>"
  end

  # Returns human readable log type.
  def log_type
    return "IAO Chamber Pressure Out of Range"
  end

end