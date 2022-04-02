class Groov::IAOProfileCancelled < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("Profile cancelled by user.", {
      iao: self.device,
      cancelled_by: self.groov_user,
      reason: self.groov_data[:reason]
    })
  end

end