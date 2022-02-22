class Groov::SupplementalAirCompressorNeeded < Groov::Log

  # Instance methods.

  # Notification settings.
  def notification_settings
    return {
      enabled: false
    }
  end

  # Log details.
  def details
		return "<p>Turned on 50HP compressor because 30HP compressor not keeping up.</p>"
  end

end