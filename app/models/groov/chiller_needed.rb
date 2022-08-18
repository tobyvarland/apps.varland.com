class Groov::PumpTooSoon < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("Pump attempted to turn on too soon after other pump.", {
      boiler1_status: (self.groov_data[:boiler1_status].to_i == 0 ? "Off" : "On"),
      boiler2_status: (self.groov_data[:boiler2_status].to_i == 0 ? "Off" : "On"),
      boiler_pressure: "#{self.limit.to_f.round(3)}; PSI",
      chiller1_status: (self.groov_data[:chiller1_status].to_i == 0 ? "Off" : "On"),
      chiller2_status: (self.groov_data[:chiller2_status].to_i == 0 ? "Off" : "On"),
      chiller3_status: (self.groov_data[:chiller3_status].to_i == 0 ? "Off" : "On"),
    })
  end

end