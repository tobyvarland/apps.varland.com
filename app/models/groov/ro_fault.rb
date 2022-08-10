class Groov::ROFault < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("RO fault.", {
      reject_overflow: (self.groov_data[:reject_overflow].to_i == 1 ? "Faulted" : "No"),
      city_water_pressure: (self.groov_data[:city_water_pressure].to_i == 1 ? "Faulted" : "No"),
      storage_overflow: (self.groov_data[:storage_overflow].to_i == 1 ? "Faulted" : "No"),
    })
  end

end