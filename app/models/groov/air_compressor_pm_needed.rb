class Groov::AirCompressorPMNeeded < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("PM needed for an air compressor.", {
      air_compressor: self.device,
      reading: self.humanize_seconds(self.reading, 3),
      previous: self.humanize_seconds(self.reading, 3),
      limit: self.humanize_seconds(self.reading, 3)
    })
  end

end