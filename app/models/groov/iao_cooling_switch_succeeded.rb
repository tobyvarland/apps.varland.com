class Groov::IAOCoolingSwitchSucceeded < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("Opto switched to the cooling profile because the soak ran long.", {
      iao: self.device
    })
  end

end