class Groov::IAONitrogenFlowRateError < Groov::Log

  # Instance methods.

  # Notification settings.
  def notification_settings
    return {
      enabled: true,
      subject: "#{self.controller_name}: Nitrogen Flow Rate Error",
      recipients: [TOBY_VARLAND_EMAIL]
    }
  end

  # Log details.
  def details
    ##{self.groov_data[:emergency_pack]}
		return "<p>Nitrogen flow rate error.</p>"
  end

  # Returns human readable log type.
  def log_type
    return "Nitrogen Flow Rate Error"
  end

end