class Groov::ChillerNeeded < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("Opto believes that a chiller is needed.", {
      boiler1_status: self.boiler1_status,
      boiler2_status: self.boiler2_status,
      boiler_pressure: "#{self.boiler_pressure.to_f.round(3)}″",
      chiller1_status: self.chiller1_status,
      chiller2_status: self.chiller2_status,
      chiller3_status: self.chiller3_status,
    })
  end

end