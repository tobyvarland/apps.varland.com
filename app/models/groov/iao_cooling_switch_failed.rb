class Groov::IAOCoolingSwitchFailed < Groov::Log

  # Instance methods.

  # Notification settings.
  def notification_settings
    return {
      enabled: true,
      subject: "#{self.controller_name}: #{self.device} Switch to Cooling Profile Failed",
      recipients: [TOBY_VARLAND_EMAIL]
    }
  end

  # Log details.
  def details
    ##{self.groov_data[:emergency_pack]}
		return "<p>IAO switch to cooling profile failed.</p><p><small>IAO:</small> <code>#{self.device}</code></p>"
  end

  # Returns human readable log type.
  def log_type
    return "IAO Switch to Cooling Profile Failed"
  end

end