class Groov::IAONotEnoughGasToStart < Groov::Log

  # Instance methods.

  # Notification settings.
  def notification_settings
    return {
      enabled: true,
      subject: "#{self.controller_name}: #{self.device} IAO Can't Start - Not Enough Gas Available",
      recipients: [TOBY_VARLAND_EMAIL]
    }
  end

  # Log details.
  def details
		return "<p>IAO can't start because not enough gas available.</p><p><small>IAO:</small> <code>#{self.device}</code><br><small>Minimum Requirement:</small> <code>#{self.limit.to_i} PSI</code><br><small>Gas Available After Tests:</small> <code>#{self.reading.to_i} PSI</code></p>"
  end

  # Returns human readable log type.
  def log_type
    return "IAO Not Enough Gas to Start"
  end

end