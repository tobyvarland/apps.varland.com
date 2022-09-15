class Groov::SiloLevelLow < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("Silo level is low.", {
      silo: self.device,
      reading: "#{self.reading.to_f.round(3)}″",
      limit: "#{self.limit.to_f.round(3)}″"
    })
  end

end