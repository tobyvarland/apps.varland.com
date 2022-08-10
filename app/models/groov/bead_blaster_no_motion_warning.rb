class Groov::BeadBlasterNoMotionWarning < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("Bead blaster is not turning.", {
      bead_blaster: self.device,
      reading: self.humanize_seconds(self.reading, 3),
      limit: self.humanize_seconds(self.reading, 3)
    })
  end

end