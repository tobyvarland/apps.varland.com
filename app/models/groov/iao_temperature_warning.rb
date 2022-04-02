class Groov::IAOTemperatureWarning < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("Parts temperature out of range during the soak operation.", {
      iao: self.device,
      reading: "#{self.reading.to_f.round(3)}&deg; F",
      low_limit: "#{self.low_limit.to_i}&deg; F",
      high_limit: "#{self.high_limit.to_i}&deg; F"
    })
  end

end