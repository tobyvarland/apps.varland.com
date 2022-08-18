class Groov::ChillerAmbientTemperatureHigh < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("Ambient temperature around mezzanine chillers is too high.", {
      tank: self.device,
      limit: "#{self.limit.to_f.round(3)}&deg; F",
      reading: "#{self.reading.to_f.round(3)}&deg; F"
    })
  end

end