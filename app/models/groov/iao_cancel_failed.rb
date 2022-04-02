class Groov::IAOCancelFailed < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("User tried to cancel profile, but termination failed.", {
      iao: self.device,
      cancelled_by: self.groov_user,
      reason: self.groov_data[:reason]
    })
  end

end