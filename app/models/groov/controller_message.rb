class Groov::ControllerMessage < Groov::Log

  # Codes to trigger email.
  NOTIFYABLE_CODES = ["-534"].freeze

  # Codes to skip logging.
  SKIPPABLE_CODES = ["-98", "-539"].freeze

  # Validations.
  validate  :require_not_skippable

  # Instance methods.

  # Force validation failure to prevent logging specific codes.
  def require_not_skippable
    errors.add(:base, "contains skippable error code") if SKIPPABLE_CODES.include?(self.groov_data[:controller_message][:code])
  end

  # Parses JSON data.
  def extract_details
    super
    json = JSON.parse(self.json_data, symbolize_names: true)
    message_info = json[:info].split('|')
    json[:controller_message] = {
      code: message_info[0],
      severity: message_info[1],
      chart: message_info[2],
      block: message_info[3],
      line: message_info[4],
      object: message_info[5],
      time: message_info[6],
      date: message_info[7]
    }
    self.json_data = JSON.generate(json)
  end

  # Notification settings.
  def notification_settings
    return {
      enabled: NOTIFYABLE_CODES.include?(self.groov_data[:controller_message][:code]),
      subject: "#{self.controller_name}: Message Queue Message",
      recipients: [TOBY_VARLAND_EMAIL]
    }
  end

  # Log details.
  def details
    case self.groov_data[:controller_message][:code].to_s
    when "-539"
      return "<p>#{GROOV_ERROR_CODES[self.groov_data[:controller_message][:code].to_s]} (<code>#{self.groov_data[:controller_message][:object]}</code>)</p>"
    else
      return "<p>#{GROOV_ERROR_CODES[self.groov_data[:controller_message][:code].to_s]}</p><p>Full details:</p><p><code>#{self.groov_data[:controller_message]}</code></p>"
    end
  end

end