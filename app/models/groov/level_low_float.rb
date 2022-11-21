class Groov::LevelLowFloat < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("A low level float warning has been detected", {
      device: self.device
    })
  end

end