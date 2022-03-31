class Groov::IAOOutOfGasError < Groov::Log

  # Instance methods.

  # Notification settings.
  def notification_settings
    return {
      enabled: true,
      subject: "#{self.controller_name}: Out of Nitrogen Gas",
      recipients: [TOBY_VARLAND_EMAIL]
    }
  end

  # Log details.
  def details
    return "<p>IAO system is out of nitrogen gas and relying on emergency supply.</p><p>Low Limit: <code>#{self.limit.to_f.round(3)} PSI</code><br>Pack 1: <code>#{self.groov_data[:pack_1].to_f.round(3)} PSI</code><br>Pack 2: <code>#{self.groov_data[:pack_2].to_f.round(3)} PSI</code><br>Emergency Supply: <code>#{self.groov_data[:emergency_pack].to_f.round(3)} PSI</code></p>"
  end

  # Returns human readable log type.
  def log_type
    return "Out of Nitrogen Gas"
  end

end