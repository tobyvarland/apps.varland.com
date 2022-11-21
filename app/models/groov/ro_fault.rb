  class Groov::ROFault < Groov::Log

    # Instance methods.

    # Log details.
    def details
      return self.format_log_data("RO fault detected.", {
        reject_overflow: self.reject_overflow,
        city_water_pressure: self.city_water_pressure,
        storage_overflow: self.storage_overflow
      })
    end

  end