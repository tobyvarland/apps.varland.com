class Groov::IAOPressureWarning < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("Chamber pressure out of range.", {
      iao: self.device,
      reading: "#{self.reading.to_f.round(3)} IWC",
      low_limit: "#{self.low_limit.to_f.round(3)} IWC",
      high_limit: "#{self.high_limit.to_f.round(3)} IWC"
    })
  end

end