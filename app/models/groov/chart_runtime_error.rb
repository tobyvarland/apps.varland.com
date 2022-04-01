class Groov::ChartRuntimeError < Groov::Log

  # Instance methods.

  # Returns notification subject.
  def notification_subject
    return "#{self.controller_name}: Chart Runtime Error"
  end

  # Notification settings.
  #def notification_settings
  #  return {
  #    enabled: true,
  #    subject: "#{self.controller_name}: Chart Runtime Error",
  #    recipients: [TOBY_VARLAND_EMAIL]
  #  }
  #end

  # Log details.
  def details
		return "<p>Chart runtime error.</p><p><small>Chart:</small> <code>#{self.device}</code><br><small>Runtime:</small> <code>#{self.reading.to_f.round(3)} seconds</code><br><small>Limit:</small> <code>#{self.limit.to_f.round(3)} seconds</code></p>"
  end

end