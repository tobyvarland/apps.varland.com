class Groov::IAOProfileFinished < Groov::Log

  # Instance methods.

  # Notification settings.
  def notification_settings
    return {
      enabled: true,
      subject: "#{self.controller_name}: #{self.device} IAO Profile Finished",
      recipients: [TOBY_VARLAND_EMAIL]
    }
  end

  # Log details.
  def details
		return "<p>IAO profile finished.</p>"
  end

  # Returns human readable log type.
  def log_type
    return "IAO Profile Finished"
  end

end