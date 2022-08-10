class Groov::SlopeUpsetWarning < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("Clarifier upset slope is out of range.", {
      limit: self.limit.to_f.round(3),
      reading: self.reading.to_f.round(3)
    })
  end

end