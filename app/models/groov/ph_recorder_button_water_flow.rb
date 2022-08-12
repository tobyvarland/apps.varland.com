class Groov::pHRecorderButtonWaterFlow < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("pH recorder button held with water flowing out of the clarifier.", {
      reading: "#{self.reading.to_f.round(3)}; GPM",
      limit: "#{self.reading.to_f.round(3)}; GPM"
    })
  end

end