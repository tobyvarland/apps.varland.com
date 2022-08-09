class Groov::ChilledTankTemperatureHigh < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("Chilled tank temperature is high.", {
      tank: self.device,
      limit: "#{self.limit.to_f.round(3)}&deg; F",
      reading: "#{self.reading.to_f.round(3)}&deg; F"
    })
  end

end