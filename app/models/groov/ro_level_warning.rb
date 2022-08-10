class Groov::ROLevelWarning < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("RO level reading out of limits.", {
      reading: "#{self.reading.to_f.round(3)} inches",
      low_limit: "#{self.low_limit.to_f.round(3)} inches",
      high_limit: "#{self.high_limit.to_f.round(3)} inches"
    })
  end

end