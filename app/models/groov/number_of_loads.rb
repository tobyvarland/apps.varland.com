class Groov::NumberOfLoads < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("Number of loads update.", {
      dept8_tz_loads: self.groov_data[:dept8_tz]
    })
  end

end