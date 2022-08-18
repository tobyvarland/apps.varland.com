class Groov::15MinutekWhLimitExceeded < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("15 kWh limit exceeded.", {
      limit: "#{self.limit.to_f.round(3)}; kWh",
      reading: "#{self.reading.to_f.round(3)}; kWh"
    })
  end

end