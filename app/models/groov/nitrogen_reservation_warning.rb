class Groov::NitrogenReservationWarning < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("IAO does not have enough nitrogen gas to fulfill reservations (without emergency supply).", {
      limit: "#{self.limit.to_i} PSI",
      available: "#{self.reading.to_i} PSI"
    })
  end

end