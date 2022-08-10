class Groov::SandFilterPressureWarning < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("Sand filter back pressure is too high.", {
      reading:  "#{self.limit.to_f.round(3)}; PSI",,
      limit:  "#{self.limit.to_f.round(3)}; PSI",,
    })
  end

end