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
    ##{self.groov_data[:emergency_pack]}
		return "<p>IAO system is out of nitrogen gas and relying on emergency supply. Low limit: <code>#{self.limit} PSI</code>. Pack 1: <code>#{self.groov_data[:pack_1]} PSI</code>. Pack 2: <code>#{self.groov_data[:pack_2]} PSI</code>. Emergency supply: <code>#{self.groov_data[:emergency_pack]} PSI</code>.</p>"
  end

  # Returns human readable log type.
  def log_type
    return "Out of Nitrogen Gas"
  end

end