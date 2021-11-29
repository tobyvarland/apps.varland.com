class Groov::TemperatureError < Groov::Log

  # Log details.
  def details
    return "<p>Temperature out of range. Reading: <code>#{self.reading}&deg; F</code>. Low Limit: <code>#{self.low_limit}&deg; F</code>. High Limit: <code>#{self.high_limit}&deg; F</code>.</p>"
  end

end