class Groov::WaterSupplyWarning < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("Water supply warning.", {
      description: self.description,
      reading: "#{self.reading.to_f.round(3)} "& self.units,
      limit: "#{self.limit.to_f.round(3)} "& self.units
    })
  end

end