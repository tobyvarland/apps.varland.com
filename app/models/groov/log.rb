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

  # Validations.
  validates :controller_name,
            presence: true
  validates :log_at,
            presence: true
  validates :json_data,
            presence: true

  # Scopes.
  scope :on_or_after, ->(value) { where("log_at >= ?", value) unless value.blank? }
  scope :on_or_before, ->(value) { where("log_at <= ?", value) unless value.blank? }
  scope :for_controller, ->(value) { where(controller_name: value) unless value.blank? }
  scope :for_device, ->(value) { where(device: value) unless value.blank? }
  scope :of_type, ->(value) { where(type: value) unless value.blank? }
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
  after_create_commit :process_notification

  # Instance methods.

  # Sends notification email if configured.
  def process_notification
    if self.notification_settings[:enabled]
      Groov::LogMailer.with(log: self).log_notification.deliver_now
    end
  end

  # Returns notification settings. Must be overridden in child class to send email.
  def notification_settings
    return {
      enabled: false,
      subject: nil,
      recipients: nil
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
  def humanize_seconds(seconds)
    [[60, :second], [60, :minute], [24, :hour], [Float::INFINITY, :day]].map{ |count, name|
      if seconds > 0
        seconds, n = seconds.divmod(count)
        "#{n} #{n == 1 ? name : name.to_s.pluralize}" unless n == 0
      end
    }.compact.reverse.join(' ')
  end

  # Class methods.

  # Humanizes log type.
  def self.humanize_log_type(type)
    formatted = type.demodulize.titleize
    substitutions = [["Ph", "pH"], ["En", "EN"], ["Io", "I/O"]]
    substitutions.each do |sub|
      formatted.gsub!(sub[0], sub[1])
    end
    return formatted
  end

end