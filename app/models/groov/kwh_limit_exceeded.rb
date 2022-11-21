class Groov::kWhLimitExceeded < Groov::Log

  # Instance methods.

  # Notification settings.
  def notification_settings
    return {
      enabled: true,
      subject: "#{self.controller_name}: 15 Minute kWh Limit Exceeded",
      recipients: [FOREMAN_EMAIL, CLIFF_QUEEN_EMAIL, RICH_BRANSON_EMAIL, TED_MCKEEHAN_EMAIL, CASEY_MCKEEHAN_EMAIL]
    }
  end

  # Log details.
  def details
		return "<p>15 minute kWh limit exceeded. Runtime: <code>#{self.reading} kWh</code>. Limit: <code>#{self.limit} kWh</code>.</p>"
  end

end