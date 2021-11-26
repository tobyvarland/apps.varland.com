class Groov::WatlowError < Groov::Log

  # Instance methods.

  # Notification settings.
  def notification_settings
    return {
      enabled: true,
      subject: "#{self.controller_name}: Watlow Communication Error",
      recipients: [TOBY_VARLAND_EMAIL]
    }
  end

  # Log details.
  def details
		return "<p>Watlow communication error for <code>#{self.device}</code>. Last communication: <code>#{self.reading} seconds ago</code>. Limit: <code>#{self.limit} seconds</code>.</p>"
  end

end