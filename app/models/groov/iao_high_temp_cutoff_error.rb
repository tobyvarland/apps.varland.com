class Groov::IAOHighTempCutoffError < Groov::Log

  # Instance methods.

  # Notification settings.
  def notification_settings
    return {
      enabled: true,
      subject: "#{self.controller_name}: #{self.device} High Temp Cutoff Error",
      recipients: [TOBY_VARLAND_EMAIL]
    }
  end

  # Log details.
  def details
    ##{self.groov_data[:emergency_pack]}
		return "<p>High temperature cutoff error.</p><p>IAO: <code>#{self.device}</code>.</p>"
  end

  # Returns human readable log type.
  def log_type
    return "IAO High Temp Cutoff Error"
  end

end