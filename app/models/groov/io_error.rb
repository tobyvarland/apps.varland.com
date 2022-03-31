class Groov::IoError < Groov::Log

  # Instance methods.

  # Notification settings.
  def notification_settings
    return {
      enabled: true,
      subject: "#{self.controller_name}: I/O Error",
      recipients: [TOBY_VARLAND_EMAIL]
    }
  end

  # Log details.
  def details
    points = []
    case self.controller_name
    when "epicww.varland.com"
      points << "<small>epiciao:</small> <code>#{self.groov_data[:epiciao].to_i == 1 ? "✔" : "✘"}</code>"
    end
    point_details = points.join("<br>")
		return "<p>I/O error.</p><p>#{point_details}</p>"
  end

  # Returns human readable log type.
  def log_type
    return "I/O Error"
  end

end