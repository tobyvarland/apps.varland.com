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
		return "<p>Parts temperature out of range during the soak operation.</p><p><small>IAO:</small> <code>#{self.device}</code><br><small>Reading:</small> <code>#{self.reading.to_f.round(3)}º F</code><br><small>Low Limit:</small> <code>#{self.low_limit.to_i}º F</code><br><small>High Limit:<small> <code>#{self.high_limit.to_i}º F</code></p>"
  end

  # Returns human readable log type.
  def log_type
    return "IAO Temperature Out of Range"
  end

end