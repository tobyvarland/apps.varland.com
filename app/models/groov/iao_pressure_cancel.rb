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
		return "<p>Profile terminated due to low pressure during purge.</p><p><small>IAO:</small> <code>#{self.device}</code><br><small>Reading:</small> <code>#{self.reading.to_f.round(3)} IWC</code><br><small>Limit:</small> <code>#{self.limit.to_f.round(3)} IWC</code></p>"
  end

  # Returns human readable log type.
  def log_type
    return "IAO Purge Pressure Termination"
  end

end