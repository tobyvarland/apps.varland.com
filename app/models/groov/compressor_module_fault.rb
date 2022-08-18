class Groov::CompressorModuleFault < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("A Chiller Compressor Module has possibly faulted.", {
      chiller1_compressor1_pressure: (self.groov_data[:chiller1_compressor1_pressure].to_i == 1 ? "Faulted" : "No"),
      chiller1_compressor2_pressure: (self.groov_data[:chiller1_compressor2_pressure].to_i == 1 ? "Faulted" : "No"),
      chiller2_compressor1_pressure: (self.groov_data[:chiller2_compressor1_pressure].to_i == 1 ? "Faulted" : "No"),
      chiller2_compressor2_pressure: (self.groov_data[:chiller2_compressor2_pressure].to_i == 1 ? "Faulted" : "No"),
      chiller3_compressor1_pressure: (self.groov_data[:chiller3_compressor1_pressure].to_i == 1 ? "Faulted" : "No"),
      chiller3_compressor2_pressure: (self.groov_data[:chiller3_compressor2_pressure].to_i == 1 ? "Faulted" : "No"),
      chiller1_compressor1_temperature: (self.groov_data[:chiller1_compressor1_temperature].to_i == 1 ? "Faulted" : "No"),
      chiller1_compressor2_temperature: (self.groov_data[:chiller1_compressor2_temperature].to_i == 1 ? "Faulted" : "No"),
      chiller2_compressor1_temperature: (self.groov_data[:chiller2_compressor1_temperature].to_i == 1 ? "Faulted" : "No"),
      chiller2_compressor2_temperature: (self.groov_data[:chiller2_compressor2_temperature].to_i == 1 ? "Faulted" : "No"),
      chiller3_compressor1_temperature: (self.groov_data[:chiller3_compressor1_temperature].to_i == 1 ? "Faulted" : "No"),
      chiller3_compressor2_temperature: (self.groov_data[:chiller3_compressor2_temperature].to_i == 1 ? "Faulted" : "No"),
    })
  end

end