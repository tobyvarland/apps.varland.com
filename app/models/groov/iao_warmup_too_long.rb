class Groov::IAOWarmupTooLong < Groov::Log

  # Instance methods.

  # Notification settings.
  def notification_settings
    return {
      enabled: true,
      subject: "#{self.controller_name}: #{self.device} Warmup Too Long",
      recipients: [TOBY_VARLAND_EMAIL]
    }
  end

  # Log details.
  def details
    ##{self.groov_data[:emergency_pack]}
		return "<p>IAO warmup taking too long.</p><p>IAO: <code>#{self.device}</code>.</p>"
  end

  # Returns human readable log type.
  def log_type
    return "IAO Warmup Too Long"
  end

end