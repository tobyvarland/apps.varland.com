class Groov::AccumAmpHours < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("Accumulated amp hour update.", {
      dept3_ni3_aah: self.groov_data[:dept3_ni3],
      dept3_ni5_aah: self.groov_data[:dept3_ni5],
      dept3_cu_aah: self.groov_data[:dept3_cu],
      dept3_bsn_aah: self.groov_data[:dept3_bsn],
      dept3_msn_aah: self.groov_data[:dept3_msn],
      dept3_cad_aah: self.groov_data[:dept3_cad],
      dept3_nz2_aah: self.groov_data[:dept3_nz2],
      dept3_nz1_aah: self.groov_data[:dept3_nz1],
      dept3_chlzn_aah: self.groov_data[:dept3_chlzn],
      dept3_cynzn_aah: self.groov_data[:dept3_cynzn],
      dept3_tz_aah: self.groov_data[:dept3_tz],
      dept3_zf_aah: self.groov_data[:dept3_zf],
      dept3_brass_aah: self.groov_data[:dept3_brass],
      dept3_enni_aah: self.groov_data[:dept3_enni],
      dept4_cu_aah: self.groov_data[:dept4_cu],
      dept4_ni1_aah: self.groov_data[:dept4_ni1],
      dept4_ni2_aah: self.groov_data[:dept4_ni2],
      dept4_ni3_aah: self.groov_data[:dept4_ni3],
      dept4_ni4_aah: self.groov_data[:dept4_ni4],
      dept5_zn_aah: self.groov_data[:dept5_zn],
      dept5_nz10_13_aah: self.groov_data[:dept5_10_13],
      dept5_nz14_19_aah: self.groov_data[:dept5_nz14_19],
      dept5_bsn_aah: self.groov_data[:dept5_bsn],
      dept5_msn_aah: self.groov_data[:dept5_msn],
      dept5_cu_aah: self.groov_data[:dept5_cu],
      dept8_tz_aah: self.groov_data[:dept8_tz]
    })
  end

end