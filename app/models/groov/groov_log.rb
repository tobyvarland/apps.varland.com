class Groov::GroovLog < Groov::Log

  # Log details.
  def details
    return "<p>Undefined log type. IT needs to define the model for <code class=\"fw-700\">#{self.groov_data[:type]}</code>.</p><p>Log details from Groov:</p><p><code>#{self.groov_data}</code></p>"
  end

end