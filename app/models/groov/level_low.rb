class Groov::LevelLow < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("Solution level is low.", {
      device: self.device,
      reading: "#{self.reading.to_f.round(3)} inches",
      limit: "#{self.limit.to_f.round(3)} inches"
    })
  end

end