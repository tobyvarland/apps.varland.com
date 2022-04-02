class Groov::IAOHighTempCutoffError < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("IAO disabled because the high temperature cutoff sensor tripped.", {
      iao: self.device
    })
  end

end