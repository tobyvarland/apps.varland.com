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
		return "<p>Nitrogen flow rate error.</p><p><small>Calculated Rate:</small> <code>#{self.reading.to_f.round(3)} PSI/min</code><br><small>Low Limit:</small> <code>#{self.low_limit.to_f.round(3)} PSI/min</code><br><small>High Limit:</small> <code>#{self.high_limit.to_f.round(3)} PSI/min</code><br><small>Oven Count:</small> <code>#{self.groov_data[:oven_count]}</code></p>"
  end

  # Returns human readable log type.
  def log_type
    return "Nitrogen Flow Rate Error"
  end

end