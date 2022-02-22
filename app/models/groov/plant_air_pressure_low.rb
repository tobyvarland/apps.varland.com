class Groov::PlantAirPressureLow < Groov::Log

  # Instance methods.

  # Notification settings.
  def notification_settings
    return {
      enabled: true,
      subject: "#{self.controller_name}: Plant Air Pressure Low",
      recipients: [FOREMAN_EMAIL, CLIFF_QUEEN_EMAIL, RICH_BRANSON_EMAIL, TED_MCKEEHAN_EMAIL, CASEY_MCKEEHAN_EMAIL]
    }
  end

  # Log details.
  def details
		return "<p>Plant air pressure is low. Reading: <code>#{self.reading} PSI</code>. Low limit: <code>#{self.limit} PSI</code>.</p>"
  end

end