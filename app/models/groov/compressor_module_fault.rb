  class Groov::ChillerCompressorFault < Groov::Log

    # Instance methods.

    # Log details.
    def details
      return self.format_log_data("A chiller compressor has faulted.", {
        chiller1_compressor1_pressure: self.chiller1_compressor1_pressure,
        chiller1_compressor1_temperature: self.chiller1_compressor1_temperature,
        chiller1_compressor2_pressure: self.chiller1_compressor2_pressure,
        chiller1_compressor2_temperature: self.chiller1_compressor2_temperature,
        chiller2_compressor1_pressure: self.chiller2_compressor1_pressure,
        chiller2_compressor1_temperature: self.chiller2_compressor1_temperature,
        chiller2_compressor2_pressure: self.chiller2_compressor2_pressure,
        chiller2_compressor2_temperature: self.chiller2_compressor2_temperature,
        chiller3_compressor1_pressure: self.chiller3_compressor1_pressure,
        chiller3_compressor1_temperature: self.chiller3_compressor1_temperature,
        chiller3_compressor2_pressure: self.chiller3_compressor2_pressure,
        chiller3_compressor2_temperature: self.chiller3_compressor2_temperature
      })
    end

  end