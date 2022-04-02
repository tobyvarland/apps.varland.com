class Groov::IAOCoolingSwitchFailed < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("Opto tried to switch to the cooling profile at the end of the soak, but the switch failed. The IAO may not be running a profile.", {
      iao: self.device
    })
  end

end