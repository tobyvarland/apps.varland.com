class Groov::IAOOutOfGasError < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("IAO system is out of nitrogen gas and relying on emergency supply.", {
      low_limit: "#{self.limit.to_f.round(3)} PSI",
      pack_1: "#{self.groov_data[:pack_1].to_f.round(3)} PSI",
      pack_2: "#{self.groov_data[:pack_2].to_f.round(3)} PSI",
      emergency_supply: "#{self.groov_data[:emergency_pack].to_f.round(3)} PSI"
    })
  end

end