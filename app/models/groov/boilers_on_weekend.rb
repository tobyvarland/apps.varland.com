class Groov::BoilersOnWeekend < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("A boiler has been detected on during the weekend.", {
      boiler1_power: "#{self.boiler1_power}",
      boiler2_power: "#{self.boiler2_power}"
    })
  end

end