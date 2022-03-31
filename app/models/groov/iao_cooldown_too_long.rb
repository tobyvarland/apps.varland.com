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
		return "<p>IAO cooldown taking too long.</p><p>IAO: <code>#{self.device}</code>.</p>"
  end

  # Returns human readable log type.
  def log_type
    return "IAO Cooldown Too Long"
  end

end