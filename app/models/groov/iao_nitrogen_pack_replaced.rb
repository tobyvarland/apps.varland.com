class Groov::IAONitrogenPackReplaced < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("Nitrogen pack replaced.", {
      pack: self.device,
      replaced_by: self.groov_user,
      psi_before: "#{self.groov_data[:before].to_i} PSI",
      psi_after: "#{self.groov_data[:after].to_i} PSI"
    })
  end

end