class Groov::LimitUpsetWarning < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("Clarifier upset limit percent is too high.", {
      limit: "#{self.limit.to_f.round(3)}; %",
      reading: "#{self.reading.to_f.round(3)}; %"
    })
  end

end