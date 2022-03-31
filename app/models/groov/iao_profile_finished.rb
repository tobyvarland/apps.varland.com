class Groov::IAOProfileFinished < Groov::Log

  # Instance methods.

  # Notification settings.
  def notification_settings
    return {
      enabled: true,
      subject: "#{self.controller_name}: #{self.device} IAO Profile Finished",
      recipients: [TOBY_VARLAND_EMAIL]
    }
  end

  # Log details.
  def details
		return "<p>IAO profile finished.</p><p><small>IAO:</small> <code>#{self.device}</code><br><small>Profile:</small> <code>#{self.groov_data[:profile]}</code><br><small>Started By:</small> <code>#{self.groov_user}</code><br><small>Total Warmup Time:</small> <code>#{(self.groov_data[:warmup_time] / 60.0).to_f.round(3)} minutes</code><br><small>Total Soak Time:</small> <code>#{(self.groov_data[:soak_time] / 60.0).to_f.round(3)} minutes</code><br><small>Total Cooldown Time:</small> <code>#{(self.groov_data[:cooldown_time] / 60.0).to_f.round(3)} minutes</code><br><small>Total Time with Gas Flow:</small> <code>#{(self.groov_data[:gas_time] / 60.0).to_f.round(3)} minutes</code><br><small>Profile Started:</small> <code>#{self.groov_data[:profile_started]}</code><br><small>Purge Ended:</small> <code>#{self.groov_data[:purge_ended]}</code><br><small>Soak Started:</small> <code>#{self.groov_data[:soak_started]}</code><br><small>Soak Ended:</small> <code>#{self.groov_data[:soak_ended]}</code><br><small>Gas Off:</small> <code>#{self.groov_data[:gas_off]}</code><br><small>Profile Ended:</small> <code>#{self.groov_data[:profile_ended]}</code><br><small>Switched to Cooling Profile:</small> <code>#{self.groov_data[:used_cooling_profile].to_i == 1 ? "Yes" : "No"}</code></p>"
  end

  # Returns human readable log type.
  def log_type
    return "IAO Profile Finished"
  end

end