class Groov::ChartRuntimeError < Groov::Log

  # Instance methods.

  # Notification settings.
  def notification_settings
    return {
      enabled: true,
      subject: "#{self.controller_name}: Chart Runtime Error",
      recipients: [TOBY_VARLAND_EMAIL]
    }
  end

  # Log details.
  def details
		return "<p>Chart runtime error. Chart: <code>#{self.device}</code> Runtime: <code>#{self.reading} seconds</code>. Limit: <code>#{self.limit} seconds</code>.</p>"
  end

end