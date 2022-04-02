class Groov::IAOProfileAlreadyRunning < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("IAO can't start because a profile is already running.", {
      iao: self.device,
      profile: self.groov_data[:profile]
    })
  end

end