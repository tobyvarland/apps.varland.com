class Groov::IAOProfileFinished < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("IAO profile finished.", {
      iao: self.device,
      profile: self.groov_data[:profile],
      started_by: self.groov_user,
      total_warmup_time: self.humanize_seconds(self.groov_data[:warmup_time].to_i),
      total_soak_time: self.humanize_seconds(self.groov_data[:soak_time].to_i),
      total_cooldown_time: self.humanize_seconds(self.groov_data[:cooldown_time].to_i),
      total_time_with_gas_flow: self.humanize_seconds(self.groov_data[:gas_time].to_i),
      total_profile_time: self.humanize_seconds(self.groov_data[:profile_time].to_i),
      profile_started_at: self.groov_data[:profile_started],
      purge_ended_at: self.groov_data[:purge_ended],
      soak_started_at: self.groov_data[:soak_started],
      soak_ended_at: self.groov_data[:soak_ended],
      gas_off_at: self.groov_data[:gas_off],
      profile_ended_at: self.groov_data[:profile_ended],
      switched_to_cooling_profile: (self.groov_data[:used_cooling_profile].to_i == 1 ? "Yes" : "No"),
      total_gas_usage: "#{self.groov_data[:total_gas_usage].to_i} PSI"
    })
  end

end