class Groov::RavenHypoWarning < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("Raven Hypo reading out of limits.", {
      raven: self.device,
      reading: "#{self.reading.to_f.round(3)}",
      limit: "#{self.low_limit.to_f.round(3)}",
    })
  end

end