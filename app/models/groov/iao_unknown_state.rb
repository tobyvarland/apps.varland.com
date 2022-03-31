class Groov::IAOUnknownState < Groov::Log

  # Instance methods.

  # Notification settings.
  def notification_settings
    return {
      enabled: true,
      subject: "#{self.controller_name}: #{self.device} IAO In Unknown State",
      recipients: [TOBY_VARLAND_EMAIL]
    }
  end

  # Log details.
  def details
    heat_output = self.groov_data[:oven_heat].to_i == 1 ? "On" : "Off"
    external_solenoid = self.groov_data[:nitrogen_shutoff].to_i == 1 ? "Open" : "Closed"
    high_flow = self.groov_data[:high_flow].to_i == 1 ? "Open" : "Closed"
    low_flow = self.groov_data[:low_flow].to_i == 1 ? "Open" : "Closed"
    gas_flow = self.groov_data[:gas_needed].to_i == 1 ? "Yes" : "No"
    profile_running = self.groov_data[:profile_running].to_i == 1 ? "Yes" : "No"
		return "<p>IAO is in unknown state.</p><p><small>IAO:</small> <code>#{self.device}</code><br><small>Heat Output from Opto:</small> <code>#{heat_output}</code><br><small>External Solenoid:</small> <code>#{external_solenoid}</code><br><small>High Flow Nitrogen Solenoid:</small> <code>#{high_flow}</code><br><small>Low Flow Nitrogen Solenoid:</small> <code>#{low_flow}</code><br><small>Gas Needed:</small> <code>#{gas_flow}</code><br><small>Profile Running:</small> <code>#{profile_running}</code><br><small>Profile Name:</small> <code>#{self.groov_data[:profile]}</code><br><small>Step #:</small> <code>#{self.groov_data[:step].to_i}</code><br><small>Step Type:</small> <code>#{self.groov_data[:step_type]}</code></p>"
  end

  # Returns human readable log type.
  def log_type
    return "IAO Unknown State"
  end

end