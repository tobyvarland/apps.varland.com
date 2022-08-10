class Groov::RavenRedoxWarning < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("Raven Redox reading out of limits.", {
      raven: self.device,
      reading: "#{self.reading.to_f.round(3)} Redox",
      low_limit: "#{self.low_limit.to_f.round(3)} Redox",
      high_limit: "#{self.high_limit.to_f.round(3)} Redox"
    })
  end

end