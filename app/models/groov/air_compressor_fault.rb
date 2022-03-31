class Groov::AirCompressorFault < Groov::Log

  # Instance methods.

  # Notification settings.
  def notification_settings
    return {
      enabled: true,
      subject: "#{self.controller_name}: #{self.groov_data[:fault_type]}",
      recipients: [FOREMAN_EMAIL, CLIFF_QUEEN_EMAIL, RICH_BRANSON_EMAIL, TED_MCKEEHAN_EMAIL, CASEY_MCKEEHAN_EMAIL]
    }
  end

  # Log details.
  def details
		return "<p>Air compressor fault. Compressor: <code>#{self.device}</code> Fault Type: <code>#{self.groov_data[:fault_type]}</code>.</p>"
  end

end