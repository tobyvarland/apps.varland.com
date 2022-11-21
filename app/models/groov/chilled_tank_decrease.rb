class Groov::ChilledTankDecrease < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("The chilled tank level has decreased.", {
      device: self.device,
      description: self.description,
      level: "#{self.level.to_f.round(3)} inches",
      reading: "#{self.reading.to_f.round(3)} inches",
      previous_level: "#{self.previous_level.to_f.round(3)} inches",
      limit: "#{self.limit.to_f.round(3)} inches"
    })
  end

end