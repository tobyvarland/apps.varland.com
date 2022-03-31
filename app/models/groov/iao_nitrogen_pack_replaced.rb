class Groov::IAONitrogenPackReplaced < Groov::Log

  # Instance methods.

  # Notification settings.
  def notification_settings
    return {
      enabled: true,
      subject: "#{self.controller_name}: Nitrogen Pack Replaced",
      recipients: [TOBY_VARLAND_EMAIL]
    }
  end

  # Log details.
  def details
		return "<p>Nitrogen pack replaced.</p>"
  end

  # Returns human readable log type.
  def log_type
    return "Nitrogen Pack Replaced"
  end

end