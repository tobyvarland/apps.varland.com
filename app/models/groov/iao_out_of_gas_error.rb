class Groov::IAOOutOfGasError < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("IAO system is out of nitrogen gas and relying on emergency supply.", {
      low_limit: "#{self.limit.to_i} PSI",
      pack_1: "#{self.groov_data[:pack_1].to_i} PSI",
      pack_2: "#{self.groov_data[:pack_2].to_i} PSI",
      emergency_supply: "#{self.groov_data[:emergency_pack].to_i} PSI"
    })
  end

end