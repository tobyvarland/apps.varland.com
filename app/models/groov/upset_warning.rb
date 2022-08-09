class Groov::UpsetWarning < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("Groov has detected an upset.", {
      upset_type: self.device,
      limit: self.limit,
      reading: self.reading
    })
  end

end