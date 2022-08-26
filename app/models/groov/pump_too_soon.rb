class Groov::PumpTooSoon < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("Pump attempted to turn on too soon.", {
      location: self.device,
      pump_previously_or_currently_running: self.groov_data[:previous_pump],
      pump_that_tried_to_turn_on: self.groov_data[:attempted_pump]
    })
  end

end