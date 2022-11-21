class Groov::BoilerFlameFailure < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("A boiler flame failure warning has been detected", {
      device: self.device
    })
  end

end