class Groov::PitLowLevelWarning < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("Pit level is too low.", {
      pit: self.device,
      limit: "#{self.limit.to_f.round(3)}; inches",
      reading: "#{self.reading.to_f.round(3)}; inches"
    })
  end

end