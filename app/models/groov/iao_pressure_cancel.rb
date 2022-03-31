class Groov::IAOPressureCancel < Groov::Log

  # Instance methods.

  # Notification settings.
  def notification_settings
    return {
      enabled: true,
      subject: "#{self.controller_name}: #{self.device} Profile Terminated Due to Low Pressure During Purge",
      recipients: [TOBY_VARLAND_EMAIL]
    }
  end

  # Log details.
  def details
		return "<p>Profile terminated due to low pressure during purge. IAO: <code>#{self.device}</code>. Reading: <code>#{self.reading} IWC</code>. Limit: <code>#{self.limit} IWC</code>.</p>"
  end

  # Returns human readable log type.
  def log_type
    return "IAO Purge Pressure Termination"
  end

end