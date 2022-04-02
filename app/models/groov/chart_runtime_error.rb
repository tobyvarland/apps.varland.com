class Groov::ChartRuntimeError < Groov::Log

  # Instance methods.

  # Log details.
  def details
    return self.format_log_data("Chart runtime error.", {
      chart: self.device,
      runtime: self.reading.to_f.round(3),
      limit: self.limit.to_f.round(3)
    })
		#return "<p>Chart runtime error.</p><p><small>Chart:</small> <code>#{self.device}</code><br><small>Runtime:</small> <code>#{self.reading.to_f.round(3)} seconds</code><br><small>Limit:</small> <code>#{self.limit.to_f.round(3)} seconds</code></p>"
  end

end