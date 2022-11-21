  class Groov::AirMakeupProbeQualityWarning < Groov::Log

    # Instance methods.

    # Log details.
    def details
      return self.format_log_data("A temperature probe is bad.", {
        dept3_probe: self.dept3_probe,
        dept4_probe: self.dept4_probe,
        dept5_probe: self.dept5_probe
      })
    end

  end