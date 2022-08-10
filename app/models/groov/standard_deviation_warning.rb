class Groov::StandardDeviationWarning < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("Standard Deviation is to high.", {
      raven: self.device,
      reading: "#{self.reading.to_f.round(3)} ORP",
      limit: "#{self.low_limit.to_f.round(3)} ORP",
    })
  end

end