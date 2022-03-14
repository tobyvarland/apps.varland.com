class Groov::GroovLog < Groov::Log

  # Instance methods.

  # Notification settings.
  def notification_settings
    return {
      enabled: true,
      subject: "#{self.controller_name}: Unconfigured Groov Log",
      recipients: [TOBY_VARLAND_EMAIL]
    }
  end

  # Log details.
  def details
    return "<p>Undefined log type. IT needs to define the model for <code class=\"fw-700\">#{self.groov_data[:type]}</code>.</p><p>Log details from Groov:</p><p><code>#{self.groov_data}</code></p>"
  end

end