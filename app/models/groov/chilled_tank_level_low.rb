class Groov::ChilledTankLevelLow < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("Chilled tank level float shows the level is low.", {
      tank: self.device
    })
  end

end