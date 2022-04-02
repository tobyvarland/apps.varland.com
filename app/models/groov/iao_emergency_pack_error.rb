class Groov::IAOEmergencyPackError < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("IAO can't start because emergency pack not ready.", {
      iao: self.device,
      minimum_requirement: "#{self.limit.to_i} PSI",
      gas_available_in_emergency_pack: "#{self.reading.to_i} PSI"
    })
  end

end