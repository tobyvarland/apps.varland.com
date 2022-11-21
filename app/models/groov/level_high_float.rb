class Groov::LevelHighFloat < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("A high level float warning has been detected", {
      device: self.device
    })
  end

end