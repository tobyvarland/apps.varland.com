class Groov::RavenORPWarning < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("Raven ORP reading out of limits.", {
      raven: self.device,
      reading: "#{self.reading.to_f.round(3)} ORP",
      low_limit: "#{self.low_limit.to_f.round(3)} ORP",
      high_limit: "#{self.high_limit.to_f.round(3)} ORP"
    })
  end

end