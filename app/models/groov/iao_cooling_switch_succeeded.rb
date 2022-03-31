class Groov::IAOCoolingSwitchSucceeded < Groov::Log

  # Instance methods.

  # Notification settings.
  def notification_settings
    return {
      enabled: true,
      subject: "#{self.controller_name}: #{self.device} Switched to Cooling Profile",
      recipients: [TOBY_VARLAND_EMAIL]
    }
  end

  # Log details.
  def details
    ##{self.groov_data[:emergency_pack]}
		return "<p>IAO switched to cooling profile.</p><p><small>IAO:</small> <code>#{self.device}</code></p>"
  end

  # Returns human readable log type.
  def log_type
    return "IAO Switched to Cooling Profile"
  end

end