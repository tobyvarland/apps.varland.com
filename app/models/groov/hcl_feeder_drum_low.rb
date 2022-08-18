class Groov::HCLFeederDrumLow < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("HCL Feeder Drum level is low.", {
      silo: self.device,
      reading: "#{self.reading.to_f.round(3)} inches",
      limit: "#{self.low_limit.to_f.round(3)} inches",
    })
  end

end