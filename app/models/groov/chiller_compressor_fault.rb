  class Groov::ChillerCompressorFault < Groov::Log

    # Instance methods.

    # Log details.
    def details
      return self.format_log_data("A chiller compressor has faulted.", {
        chiller1_compressor1: self.chiller1_compressor1,
        chiller1_compressor2: self.chiller1_compressor2,
        chiller2_compressor1: self.chiller2_compressor1,
        chiller2_compressor2: self.chiller2_compressor2,
        chiller3_compressor1: self.chiller3_compressor1,
        chiller3_compressor2: self.chiller3_compressor2
      })
    end

  end