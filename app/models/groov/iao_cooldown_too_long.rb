class Groov::IAOCooldownTooLong < Groov::Log

  # Instance methods.

  # Notification settings.
  def notification_settings
    return {
      enabled: true,
      subject: "#{self.controller_name}: #{self.device} Cooldown Too Long",
      recipients: [TOBY_VARLAND_EMAIL]
    }
  end

  # Log details.
  def details
    ##{self.groov_data[:emergency_pack]}
		return "<p>IAO cooldown taking too long.</p><p><small>IAO:</small> <code>#{self.device}</code><br><small>Elapsed Time:</small> <code>#{(self.reading / 60.0).to_f.round(3)} minutes</code><br><small>Limit:</small> <code>#{(self.limit / 60.0).to_i} minutes</code></p>"
  end

  # Returns human readable log type.
  def log_type
    return "IAO Cooldown Too Long"
  end

end