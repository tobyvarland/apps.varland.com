class Groov::IAOProfileFailedToStart < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("IAO failed to start after all checks completed.", {
      iao: self.device,
      profile: self.groov_data[:profile]
    })
  end

end