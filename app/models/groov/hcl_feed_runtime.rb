class Groov::HclFeedRuntime < Groov::Log

  # Instance methods.

  # Notification settings.
  def notification_settings
    return {
      enabled: false,
      subject: "#{self.controller_name}: HCL Feed Runtime",
      recipients: [TOBY_VARLAND_EMAIL]
    }
  end

  # Log details.
  def details
		return "<p>HCL feed runtime. Pump: <code>#{self.device}</code> Amount: <code>#{self.reading} seconds</code>.</p>"
  end

  # Returns human readable log type.
  def log_type
    return "HCL Feed Runtime"
  end

end