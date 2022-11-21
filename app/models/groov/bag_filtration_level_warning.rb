class Groov::BagFiltrationLevelWarning < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("Bag Filter level is high.", {
      limit: "#{self.limit.to_f.round(3)}; inches",
      reading: "#{self.reading.to_f.round(3)}; inches"
    })
  end

end