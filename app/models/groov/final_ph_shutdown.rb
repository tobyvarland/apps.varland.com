class Groov::FinalPhShutdown < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("Wastewater has shutdown! Final pH reading out of limits.", {
      reading: "#{self.reading.to_f.round(3)}",
      low_limit: "#{self.low_limit.to_f.round(3)}",
      high_limit: "#{self.high_limit.to_f.round(3)}"
    })
  end

end