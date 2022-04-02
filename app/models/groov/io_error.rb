class Groov::IoError < Groov::Log

  # Instance methods.

  # Log details.
  def details
    details = {}
    self.groov_data.each {|key, value|
      unless [:timestamp, :type, :controller_name, :notifications].include?(key)
        details[key] = value.to_i == 1 ? "OK" : "Error"
      end
    }
    return self.format_log_data("I/O error.", details, true)
  end

end