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
  default_scope -> { by_due_date }
  scope :by_due_date, -> { order("ISNULL(`next_result_due_on`), `next_result_due_on`") }
  scope :kept, -> { undiscarded.joins(:record_type).joins(:device).merge(Records::RecordType.kept).merge(Records::Device.kept) }
  scope :for_device_and_type, ->(device, type) { where(device_id: device).where(record_type_id: type) }

  # Validations.
	validates	:device_id,
            uniqueness: { scope: :record_type_id }
  validates	:record_type_id,
            uniqueness: { scope: :device_id }

  # Callbacks.
  before_create :initialize_due_date

  # Instance methods.

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