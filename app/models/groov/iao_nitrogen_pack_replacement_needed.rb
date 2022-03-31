class Groov::IAONitrogenPackReplacementNeeded < Groov::Log

  # Instance methods.

  # Notification settings.
  def notification_settings
    return {
      enabled: true,
      subject: "#{self.controller_name}: Nitrogen Pack Replacement Needed",
      recipients: [TOBY_VARLAND_EMAIL]
    }
  end

  # Log details.
  def details
		return "<p>Nitrogen pack replacement needed.</p><p><small>PSI Empty Limit:</small> <code>#{self.limit.to_i} PSI</code><br><small>Pack 1:</small> <code>#{self.groov_data[:pack_1].to_i} PSI</code><br><small>Pack 1:</small> <code>#{self.groov_data[:pack_2].to_i} PSI</code></p>"
  end

  # Returns human readable log type.
  def log_type
    return "Nitrogen Pack Replacement Needed"
  end

end