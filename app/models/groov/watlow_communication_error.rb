class Groov::WatlowCommunicationError < Groov::Log

  # Instance methods.

  # Notification settings.
  def notification_settings
    return {
      enabled: true,
      subject: "#{self.controller_name}: #{self.device} Watlow Communication Error",
      recipients: [TOBY_VARLAND_EMAIL]
    }
  end

  # Log details.
  def details
    ##{self.groov_data[:emergency_pack]}
		return "<p>Watlow communication failure.</p><p><small>IAO:</small> <code>#{self.device}</code><br><small>Seconds Since Communication:</small> <code>#{self.reading.to_f.round(3)} seconds</code><br><small>Limit:</small> <code>#{self.limit.to_i} seconds</code></p>"
  end

  # Returns human readable log type.
  def log_type
    return "Watlow Communication Error"
  end

end