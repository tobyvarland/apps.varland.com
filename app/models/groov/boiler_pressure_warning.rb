class Groov::BoilerPressureWarning < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("Boiler pressure is out of limits.", {
      reading: "#{self.reading.to_f.round(3)} psi",
      low_limit: "#{self.low_limit.to_f.round(3)} psi",
      high_limit: "#{self.high_limit.to_f.round(3)} psi"
    })
  end

end