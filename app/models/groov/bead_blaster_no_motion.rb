class Groov::BeadBlasterNoMotion < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("Bead blaster is on, but no motion has been detected.", {
      reading: "#{self.reading.to_f.round(3)}",
      limit: "#{self.limit.to_f.round(3)}"
    })
  end

end