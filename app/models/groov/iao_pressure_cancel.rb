class Groov::IAOPressureCancel < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("Profile terminated due to low pressure during purge.", {
      iao: self.device,
      reading: "#{self.reading.to_f.round(3)} IWC",
      limit: "#{self.limit.to_f.round(3)} IWC"
    })
  end

end