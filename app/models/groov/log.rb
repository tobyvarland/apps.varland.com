class Groov::Log < ApplicationRecord

  # Concerns.
  include ShopOrderAssignable

  # Soft deletes.
  include Discard::Model
  default_scope -> { kept }

  # Associations.
  belongs_to  :shop_order,
              class_name: 'AS400::ShopOrder',
              optional: true
  belongs_to  :user,
              class_name: '::User',
              optional: true

  # Validations.
  validates :controller_name,
            presence: true
  validates :log_at,
            presence: true
  validates :json_data,
            presence: true,
            uniqueness: true

  # Scopes.
  include TextSearchable
  scope :on_or_after, ->(value) { where("DATE(log_at) >= ?", value) unless value.blank? }
  scope :on_or_before, ->(value) { where("DATE(log_at) <= ?", value) unless value.blank? }
  scope :for_controller, ->(value) { where(controller_name: value) unless value.blank? }
  scope :for_device, ->(value) { where(device: value) unless value.blank? }
  scope :of_type, ->(value) { where(type: value) unless value.blank? }
  scope :with_search_term, ->(value) {
    return if value.blank?
    with_text_containing(:description, value)
  }
  scope :sorted_by, ->(value) {
    case value
    when 'oldest'
      order(:log_at)
    else
      order(log_at: :desc)
    end
  }

  # Callbacks.
  after_create_commit { Groov::LogBroadcastJob.perform_now self }
  after_create_commit { Groov::ProcessNotificationJob.perform_later self }
  before_save { self.update_description }

  # Instance methods.

  # Updates description in database before save.
  def update_description
    description = self.details
    substitutions = [["<br>", "\n"],
                     ["<br />", "\n"]]
    substitutions.each do |sub|
      description.gsub!(sub[0], sub[1])
    end
    self.description = ActionView::Base.full_sanitizer.sanitize(description)
  end

  # Returns notification subject. May be overridden in child class.
  def notification_subject
    return "#{self.controller_name}: #{self.log_type}"
  end

  # Parses groov notification recipients.
  def parse_groov_recipients
    return [] unless self.groov_data[:notifications].present?
    return [] if self.groov_data[:notifications].to_i == 0
    flags = self.groov_data[:notifications].to_i.to_s(2).rjust(32, '0').split("").reverse().map {|x| x == "1"}
    recipients = []
    recipients << GROOV_IT_EMAIL if flags[0]
    recipients << GROOV_MAINTENANCE_EMAIL if flags[1]
    recipients << FOREMAN_EMAIL if flags[2]
    recipients << GROOV_PRODUCTION_EMAIL if flags[3]
    recipients << GROOV_LAB_EMAIL if flags[4]
    recipients << GROOV_QC_EMAIL if flags[5]
    recipients << JOHN_MCGUIRE_EMAIL if flags[29]
    recipients << MARK_STRADER_EMAIL if flags[30]
    recipients << TOBY_VARLAND_EMAIL if flags[31]
    return recipients
  end

  # Returns notification settings. Must be overridden in child class to send email.
  def notification_settings
    groov_recipients = self.parse_groov_recipients
    return {
      enabled: (groov_recipients.length > 0),
      subject: self.notification_subject,
      recipients: groov_recipients
    }
  end

  # Gets email recipients.
  def get_recipients
    recipients = self.notification_settings[:recipients]
    if recipients.include?(FOREMAN_EMAIL)
      recipients.delete(FOREMAN_EMAIL)
      addresses = JSON.parse(Net::HTTP.get(URI.parse(URI.escape("http://timeclock.varland.com/foremen_email.json"))))
      addresses.each do |email|
        recipients << email
      end
    end
    return recipients
  end

  # Returns user name (or "unknown") for log.
  def groov_user
    return self.user.blank? ? "Unknown" : self.user.name
  end

  # Returns parsed JSON data for all data passed by Opto controller.
  def groov_data
    return JSON.parse(self.json_data, symbolize_names: true)
  end

  # Default details string. Should be overridden in child class.
  def details
    return "<p><code>#{self.groov_data.to_s}</code></p>"
  end

  # Returns human readable log type. May be overridden in child class for special cases.
  def log_type
    return Groov::Log.humanize_log_type(self.type)
  end

  # Parses JSON data.
  def extract_details
    json = JSON.parse(self.json_data, symbolize_names: true)
    self.log_at = json[:timestamp].present? ? Time.zone.strptime(json[:timestamp], "%m/%d/%Y %H:%M:%S") : DateTime.current
    self.shop_order_number = json[:shop_order] if json[:shop_order].present?
    self.user = User.where(employee_number: json[:employee_number]).first if json[:employee_number].present? && json[:employee_number] != 0
    [:lane,
     :station,
     :load,
     :barrel,
     :reading,
     :limit,
     :low_limit,
     :high_limit,
     :device].each do |attr|
      self[attr] = json.fetch(attr, nil)
    end
  end

  # Humanizes seconds.
  def humanize_seconds(seconds, decimals = 0)
    [[60, :second], [60, :minute], [24, :hour], [Float::INFINITY, :day]].map{ |count, name|
      if seconds > 0
        seconds, n = seconds.divmod(count)
        if name == :second
          if decimals == 0
            "#{n.to_i} #{n == 1 ? name : name.to_s.pluralize}" unless n == 0
          else
            "#{n.to_f.round(decimals)} #{n == 1 ? name : name.to_s.pluralize}" unless n == 0
          end
        else
          "#{n} #{n == 1 ? name : name.to_s.pluralize}" unless n == 0
        end
      end
    }.compact.reverse.join(' ')
  end

  # Formats standard log message.
  def format_log_data(text, fields, lowercase_field_labels = false)
    data = "<p>#{text}</p><p>"
    data_fields = []
    fields.each {|key, value| data_fields << "<small>#{lowercase_field_labels ? key.to_s : Groov::Log.humanize_log_type(key.to_s)}:</small> <code>#{value}</code>" }
    data += data_fields.join("<br>")
    data += "</p>"
    return data
  end

  # Class methods.

  # Humanizes log type.
  def self.humanize_log_type(type)
    formatted = type.demodulize.titleize
    formatted.gsub!(/\bPh\b/, 'pH')
    formatted.gsub!(/\bEn\b/, 'EN')
    formatted.gsub!(/\bIo\b/, 'I/O')
    formatted.gsub!(/\bIao\b/, 'IAO')
    formatted.gsub!(/\bPsi\b/, 'PSI')
    formatted.gsub!(/\bIwc\b/, 'IWC')
    formatted.gsub!(/\bOrp\b/, 'ORP')
    formatted.gsub!(/\bAa\b/, 'AA')
    #substitutions = [['Ph', "pH"],
    #                 ['En', "EN"],
    #                 ['Io', "I/O"],
    #                 ['Iao', "IAO"],
    #                 ['Psi', "PSI"],
    #                 ['Iwc', "IWC"]]
    #substitutions.each do |sub|
    #  formatted.gsub!("\\b#{sub[0]}\\b", sub[1])
    #end
    return formatted
  end

end