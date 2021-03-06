class Records::Assignment < ApplicationRecord

  # Soft deletes.
  include Discard::Model
  default_scope -> { kept }

  # Associations.
  belongs_to  :device,
              class_name: "Records::Device",
              foreign_key: "device_id",
              inverse_of: :assignments
  belongs_to  :record_type,
              class_name: "Records::RecordType",
              foreign_key: "record_type_id",
              inverse_of: :assignments

  # Scopes.
  scope :by_due_date, -> { joins(:record_type).joins(:device).order("ISNULL(`records_assignments`.`next_result_due_on`), `records_assignments`.`next_result_due_on`, `records_record_types`.`name`, `records_devices`.`name`") }
  scope :by_device, -> { joins(:device).order("`records_devices`.`name`") }
  scope :by_type, -> { joins(:record_type).order("`records_record_types`.`name`") }
  scope :kept, -> { undiscarded.joins(:record_type).joins(:device).merge(Records::RecordType.kept).merge(Records::Device.kept) }
  scope :for_active_device, -> { joins(:device).merge(Records::Device.not_retired) }
  scope :for_device_and_type, ->(device, type) { where(device_id: device).where(record_type_id: type) }
  scope :with_due_date, -> { where.not(next_result_due_on: nil) }
  scope :due_on_or_before, ->(value) { where("next_result_due_on <= ?", value) unless value.blank? }
  scope :due_within_days, ->(value) { where("next_result_due_in_days <= ?", value) unless value.blank? }
  scope :for_record_type, ->(value) { where(record_type_id: value) unless value.blank? }
  scope :for_device, ->(value) { where(device_id: value) unless value.blank? }
  scope :for_data_type, ->(value) { joins(:record_type).merge(Records::RecordType.for_data_type(value)) }
  scope :for_responsibility, ->(value) { joins(:record_type).merge(Records::RecordType.for_responsibility(value)) }

  # Validations.
	validates	:device_id,
            uniqueness: { scope: :record_type_id }
  validates	:record_type_id,
            uniqueness: { scope: :device_id }

  # Callbacks.
  before_create :initialize_due_date

  # Instance methods.

  # Make sure due date is workday.
  def ensure_due_date_is_workday
    return if self.next_result_due_on.blank?
    uri = URI.parse("http://vcmsapi.varland.com/workday?date=#{self.next_result_due_on.strftime("%Y-%m-%d")}")
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    return unless response.code.to_s == "200"
    date_info = JSON.parse(response.body, symbolize_names: true)
    return if date_info[:is_workday]
    if self.record_type && self.record_type.frequency && self.record_type.frequency == 1
      self.next_result_due_on = date_info[:next_workday].to_date
    else
      self.next_result_due_on = date_info[:previous_workday].to_date
    end
  end

  # Updates results (called from after_commit callback in result)
  def update_results
    self.results_updated_at = DateTime.current
    last_result = Records::Result.for_device_and_type(self.device_id, self.record_type_id).reverse_chronological.first
    if last_result
      self.last_result_on = last_result.result_on
    end
    self.set_next_due_date
    self.save
  end

  # Sets next result due date.
  def set_next_due_date
    if self.record_type.frequency.blank?
      self.next_result_due_on = nil
      self.next_result_due_in_days = nil
    else
      if self.last_result_on.blank?
        self.next_result_due_on = Date.current
      else
        self.next_result_due_on = self.last_result_on + self.record_type.frequency.days
      end
      self.ensure_due_date_is_workday
      self.update_days_until_due
    end
  end

  # Updates days until due.
  def update_days_until_due
    self.next_result_due_in_days = self.next_result_due_on.blank? ? nil : (self.next_result_due_on - Date.current).to_i
  end

  # Initialize due date.
  def initialize_due_date
    return if self.record_type.blank?
    self.set_next_due_date
  end

  # Class methods.

end