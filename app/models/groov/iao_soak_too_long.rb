class Groov::IAOSoakTooLong < Groov::Log

  # Instance methods.

  # Notification settings.
  def notification_settings
    return {
      enabled: true,
      subject: "#{self.controller_name}: #{self.device} Soak Too Long",
      recipients: [TOBY_VARLAND_EMAIL]
    }
  end

  # Log details.
  def details
    ##{self.groov_data[:emergency_pack]}
		return "<p>IAO soak taking too long.</p>"
  end

  # Returns human readable log type.
  def log_type
    return "IAO Soak Too Long"
  end

end