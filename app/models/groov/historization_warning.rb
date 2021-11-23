class Groov::HistorizationWarning < Groov::Log

  # Instance methods.

  # Notification settings.
  def notification_settings
    return {
      enabled: true,
      subject: "#{self.controller_name}: Historization Warning",
      recipients: [TOBY_VARLAND_EMAIL]
    }
  end

  # Log details.
  def details
    return "<p>Historization not working. Duration: <code>#{self.humanize_seconds self.reading}</code>. Limit: <code>#{self.humanize_seconds self.limit}</code>.</p>"
  end

end