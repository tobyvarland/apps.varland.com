class Groov::LevelOutOfLimits < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("Solution level is out of limits.", {
      device: self.device,
      reading: "#{self.reading.to_f.round(3)} pH",
      low_limit: "#{self.low_limit.to_f.round(3)} pH",
      high_limit: "#{self.high_limit.to_f.round(3)} pH"
    })
  end

end