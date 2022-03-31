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
		return "<p>Nitrogen pack replaced.</p><p><small>Pack:</small> <code>#{self.device}</code><br><small>Replaced By:</small> <code>#{self.groov_user}</code><br><small>PSI Before:</small> <code>#{self.groov_data[:before].to_i} PSI</code><br><small>PSI After:</small> <code>#{self.groov_data[:after].to_i} PSI</code></p>"
  end

  # Returns human readable log type.
  def log_type
    return "Nitrogen Pack Replaced"
  end

end