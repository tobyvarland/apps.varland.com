class Groov::RuntimeLimitExceeded75hp < Groov::Log

  # Instance methods.

  # Notification settings.
  def notification_settings
    return {
      enabled: true,
      subject: "#{self.controller_name}: 75HP Compressor Runtime Limit Exceeded",
      recipients: [FOREMAN_EMAIL, CLIFF_QUEEN_EMAIL, RICH_BRANSON_EMAIL, TED_MCKEEHAN_EMAIL, CASEY_MCKEEHAN_EMAIL]
    }
  end

  # Log details.
  def details
		return "<p>75HP compressor runtime limit exceeded. Runtime: <code>#{self.reading} seconds</code>. Limit: <code>#{self.limit} seconds</code>.</p>"
  end

end