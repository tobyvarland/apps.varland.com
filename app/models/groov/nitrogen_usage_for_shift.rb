class Groov::NitrogenUsageForShift < Groov::Log

  # Instance methods.

  # Notification settings.
  def notification_settings
    return {
      enabled: true,
      subject: "#{self.controller_name}: Nitrogen Usage For Shift",
      recipients: [TOBY_VARLAND_EMAIL]
    }
  end

  # Log details.
  def details
		return "<p>Nitrogen usage for shift: <code>#{self.groov_data[:total_usage]} PSI</code>.</p>"
  end

end