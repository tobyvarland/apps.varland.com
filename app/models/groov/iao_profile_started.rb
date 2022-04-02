class Groov::IAOProfileStarted < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("IAO failed to start after all checks completed.", {
      iao: self.device,
      profile: self.groov_data[:profile],
      started_by: self.groov_user,
      psi_available: "#{self.groov_data[:total_gas].to_i} PSI"
    })
  end

end