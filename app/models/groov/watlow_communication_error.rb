class Groov::WatlowCommunicationError < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("Watlow communication failure.", {
      iao: self.device,
      seconds_since_communication: self.humanize_seconds(self.reading, 3),
      limit: self.humanize_seconds(self.limit, 3)
    })
  end

end