class Groov::PotentiometerError < Groov::Log

  # Instance methods.

  # Notification settings.
  def notification_settings
    return {
      enabled: true,
      subject: "#{self.controller_name}: Potentiometer Error",
      recipients: [TOBY_VARLAND_EMAIL]
    }
  end

  # Log details.
  def details
    return "<p>Potentiometer out of range. Reading: <code>#{self.reading}%</code>. Low Limit: <code>#{self.low_limit}%</code>. High Limit: <code>#{self.high_limit}%</code>.</p>"
  end

end