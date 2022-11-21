  class Groov::ZincNickelPercentWarning < Groov::Log

    # Instance methods.

    # Log details.
    def details
      return self.format_log_data("A zinc-nickel percent is out of limits.", {
        high_alloy: "#{self.high_alloy.to_f.round(3)}",
        low_alloy: "#{self.low_alloy.to_f.round(3)}",
        tri_black: "#{self.tri_black.to_f.round(3)}",
      })
    end

  end