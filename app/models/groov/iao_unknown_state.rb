class Groov::IAOUnknownState < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("IAO is in unknown state.", {
      iao: self.device,
      heat_output_from_opto: (self.groov_data[:oven_heat].to_i == 1 ? "On" : "Off"),
      external_solenoid: (self.groov_data[:nitrogen_shutoff].to_i == 1 ? "Open" : "Closed"),
      high_flow_nitrogen_solenoid: (self.groov_data[:high_flow].to_i == 1 ? "Open" : "Closed"),
      low_flow_nitrogen_solenoid: (self.groov_data[:low_flow].to_i == 1 ? "Open" : "Closed"),
      gas_needed: (self.groov_data[:gas_needed].to_i == 1 ? "Yes" : "No"),
      profile_running: (self.groov_data[:profile_running].to_i == 1 ? "Yes" : "No"),
      profile_name: self.groov_data[:provile],
      step_number: self.groov_data[:step],
      step_type: self.groov_data[:step_type]
    })
  end

end