class Groov::IAOCancelFailed < Groov::Log

  # Instance methods.

  # Notification settings.
  def notification_settings
    return {
      enabled: true,
      subject: "#{self.controller_name}: #{self.device} Profile Cancellation Failed",
      recipients: [TOBY_VARLAND_EMAIL]
    }
  end

  # Log details.
  def details
		return "<p>User tried to cancel profile, but termination failed.</p><p><small>IAO:</small> <code>#{self.device}</code><br><small>Cancelled By:</small> <code>#{self.groov_user}</code><br><small>Reason:</small> <code>#{self.groov_data[:reason]}</code></p>"
  end

  # Returns human readable log type.
  def log_type
    return "IAO Profile Cancellation Failed"
  end

end