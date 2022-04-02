class Groov::IAONitrogenPackReplacementNeeded < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("Nitrogen pack replacement needed.", {
      psi_empty_limit: "#{self.limit.to_i} PSI",
      pack_1: "#{self.groov_data[:pack_1].to_i} PSI",
      pack_2: "#{self.groov_data[:pack_2].to_i} PSI"
    })
  end

end