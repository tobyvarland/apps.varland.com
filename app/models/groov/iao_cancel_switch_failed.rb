class Groov::IAOCancelSwitchFailed < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("User tried to cancel profile, but switch to cooling profile failed.", {
      iao: self.device,
      cancelled_by: self.groov_user,
      reason: self.groov_data[:reason]
    })
  end

end