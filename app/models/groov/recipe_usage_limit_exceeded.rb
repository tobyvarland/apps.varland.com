class Groov::RecipUsageLimitExceeded < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("Recip compressor has been on for too long.", {
      limit: self.humanize_seconds(self.reading, 3),
      reading: self.humanize_seconds(self.reading, 3)
    })
  end

end