class Groov::IAOProfileTerminateFailed < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("IAO profile termination failed. Opto tried to terminate the profile due to low pressure during the purge, but the terminate command failed.", {
      iao: self.device
    })
  end

end