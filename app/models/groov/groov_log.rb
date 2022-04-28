class Groov::GroovLog < Groov::Log

  # Instance methods.

  # Returns notification subject. May be overridden in child class.
  def notification_subject
    return "#{self.controller_name}: Unconfigured Groov Log"
  end

  # Log details.
  def details
    return "<p>Undefined log type. IT needs to define the model for <code class=\"fw-700\">#{self.groov_data[:type]}</code>.</p><p>Log details from Groov:</p><p><code>#{self.groov_data}</code></p>"
  end

end