class Groov::IAONotEnoughGasToStart < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("IAO can't start because not enough gas is available.", {
      iao: self.device,
      minimum_requirement: "#{self.limit.to_i} PSI",
      gas_available_after_tests: "#{self.reading.to_i} PSI"
    })
  end

end