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
		return "<p>Opto tried to switch to the cooling profile at the end of the soak, but the switch failed. The IAO may not be running a profile.</p><p><small>IAO:</small> <code>#{self.device}</code></p>"
  end

  # Returns human readable log type.
  def log_type
    return "IAO Switch to Cooling Profile Failed"
  end

end