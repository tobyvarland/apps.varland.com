class Groov::PhRecorderButtonTooLong < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("pH recorder button held too long.", {
      reading: self.humanize_seconds(self.reading, 3),
      limit: self.humanize_seconds(self.reading, 3)
    })
  end

end