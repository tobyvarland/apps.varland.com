class Groov::HclFeedNeeded < Groov::Log

  # Instance methods.

  # Notification settings.
  def notification_settings
    return {
      enabled: false,
      subject: "#{self.controller_name}: HCL Feed Needed",
      recipients: [TOBY_VARLAND_EMAIL]
    }
  end

  # Log details.
  def details
		return "<p>HCL feed needed. Pump: <code>#{self.device}</code>. Amount: <code>#{self.reading} gal</code>.</p>"
  end

  # Returns human readable log type.
  def log_type
    return "HCL Feed Needed"
  end

end