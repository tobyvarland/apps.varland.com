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
    return "<p>IAO system is out of nitrogen gas and relying on emergency supply.</p><p><small>Low Limit:</small> <code>#{self.limit.to_f.round(3)} PSI</code><br><small>Pack 1:</small> <code>#{self.groov_data[:pack_1].to_f.round(3)} PSI</code><br><small>Pack 2:</small> <code>#{self.groov_data[:pack_2].to_f.round(3)} PSI</code><br><small>Emergency Supply:</small> <code>#{self.groov_data[:emergency_pack].to_f.round(3)} PSI</code></p>"
  end

  # Returns human readable log type.
  def log_type
    return "Out of Nitrogen Gas"
  end

end