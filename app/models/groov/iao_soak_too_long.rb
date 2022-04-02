class Groov::IAOSoakTooLong < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("IAO soak taking too long.", {
      iao: self.device,
      elapsed_time: self.humanize_seconds(self.reading, 3),
      limit: self.humanize_seconds(self.limit)
    })
  end

end