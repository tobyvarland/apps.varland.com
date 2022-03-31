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
		return "<p>IAO can't start because not enough gas available.</p>"
  end

  # Returns human readable log type.
  def log_type
    return "IAO Not Enough Gas to Start"
  end

end