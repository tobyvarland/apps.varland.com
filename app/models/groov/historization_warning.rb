class Groov::HistorizationWarning < Groov::Log

  # Log details.
  def details
    return "<p>Historization not working. Duration: <code>#{self.humanize_seconds self.reading}</code>. Limit: <code>#{self.humanize_seconds self.limit}</code>.</p>"
  end

end