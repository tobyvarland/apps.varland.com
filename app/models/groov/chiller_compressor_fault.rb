class Groov::ChillerCompressorFault < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("A Chiller Compressor has faulted.", {
      chiller1_compressor1: (self.groov_data[:chiller1_compressor1].to_i == 1 ? "Faulted" : "No"),
      chiller1_compressor2: (self.groov_data[:chiller1_compressor2].to_i == 1 ? "Faulted" : "No"),
      chiller2_compressor1: (self.groov_data[:chiller2_compressor1].to_i == 1 ? "Faulted" : "No"),
      chiller2_compressor2: (self.groov_data[:chiller2_compressor2].to_i == 1 ? "Faulted" : "No"),
      chiller3_compressor1: (self.groov_data[:chiller3_compressor1].to_i == 1 ? "Faulted" : "No"),
      chiller3_compressor2: (self.groov_data[:chiller3_compressor2].to_i == 1 ? "Faulted" : "No"),
    })
  end

end