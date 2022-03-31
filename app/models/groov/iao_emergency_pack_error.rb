class Groov::IAOEmergencyPackError < Groov::Log

  # Instance methods.

  # Notification settings.
  def notification_settings
    return {
      enabled: true,
      subject: "#{self.controller_name}: #{self.device} IAO Can't Start - Emergency Pack Not Ready",
      recipients: [TOBY_VARLAND_EMAIL]
    }
  end

  # Log details.
  def details
		return "<p>IAO can't start because emergency pack not ready.</p><p><small>IAO:</small> <code>#{self.device}</code>.</p>"
  end

  # Returns human readable log type.
  def log_type
    return "IAO Emergency Pack Not Ready"
  end

end