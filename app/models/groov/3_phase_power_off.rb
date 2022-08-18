class Groov::3PhasePowerOff < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("3-Phase power is off.", {
      limit: self.humanize_seconds(self.reading, 3),
      reading: self.humanize_seconds(self.reading, 3)
    })
  end

end