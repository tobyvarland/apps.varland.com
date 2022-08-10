class Groov::ChilledTankDailyDecrease < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("Chilled tank level has decreased too much in one day.", {
      tank: self.device,
      reading: "#{self.limit.to_f.round(3)}; inches",
      limit: "#{self.limit.to_f.round(3)}; inches",
      level: "#{self.limit.to_f.round(3)}; inches",
      previous_level: "#{self.limit.to_f.round(3)}; inches"
    })
  end

end