class Groov::SaltSprayTemperatureWarning < Groov::Log

  # Instance methods.

  # Notification settings.
  def notification_settings
    return {
      enabled: true,
      subject: "#{self.controller_name}: Salt Spray Temperature Out of Limits",
      recipients: [FOREMAN_EMAIL, GREG_TURNER_EMAIL, GREG_TURNER_SMS, RICH_BRANSON_EMAIL]
    }
  end

  # Log details.
  def details
		return "<p>Salt spray temperature is out of limits. Reading: <code>#{self.reading}º F</code>. Low limit: <code>#{self.low_limit}º F</code>. High limit: <code>#{self.high_limit}º F</code>.</p>"
  end

end