class Groov::IAONitrogenFlowRateError < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("Nitrogen flow rate is out of range.", {
      calculated_rate: "#{self.reading.to_f.round(3)} PSI/min",
      low_limit: "#{self.low_limit.to_f.round(3)} PSI/min",
      high_limit: "#{self.high_limit.to_f.round(3)} PSI/min",
      oven_count: self.groov_data[:oven_count]
    })
  end

end