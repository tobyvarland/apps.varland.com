class Records::Result < ApplicationRecord

  # Soft deletes.
  include Discard::Model
  default_scope -> { kept }

  # Associations.
  belongs_to  :device,
              class_name: "Records::Device",
              foreign_key: "device_id",
              inverse_of: :results
  belongs_to  :record_type,
              class_name: "Records::RecordType",
              foreign_key: "record_type_id",
              inverse_of: :results
  belongs_to  :user,
              class_name: "::User",
              foreign_key: "user_id"
  belongs_to  :reason_code,
              class_name: "Records::ReasonCode",
              foreign_key: "reason_code_id",
              inverse_of: :results

  # Scopes.
  scope :kept, -> { undiscarded.joins(:record_type).joins(:device).merge(Records::RecordType.kept).merge(Records::Device.kept) }
  scope :for_device_and_type, ->(device, type) { where(device_id: device).where(record_type_id: type) }
  scope :for_record_type, ->(value) { where(record_type_id: value) unless value.blank? }
  scope :for_device, ->(value) { where(device_id: value) unless value.blank? }
  scope :for_reason_code, ->(value) { where(reason_code_id: value) unless value.blank? }
  scope :for_user, ->(value) { where(user_id: value) unless value.blank? }
  scope :for_data_type, ->(value) { joins(:record_type).merge(Records::RecordType.for_data_type(value)) }
  scope :for_responsibility, ->(value) { joins(:record_type).merge(Records::RecordType.for_responsibility(value)) }
  scope :reverse_chronological, -> { order(result_on: :desc) }
  scope :on_or_after, ->(value) { where("result_on >= ?", value) unless value.blank? }
  scope :on_or_before,  ->(value) { where("result_on <= ?", value) unless value.blank? }
  scope :with_math_field, ->(field, value) { where("records_results.#{field} #{value}") unless value.blank? }
  scope :with_boolean_field, ->(field, value) {
    return if value.blank?
    test_value = "FALSE"
    test_value = "TRUE" if value == true
    test_value = "TRUE" if value == "true"
    test_value = "TRUE" if value == 1
    test_value = "TRUE" if value == "1"
    where("records_results.#{field} IS #{test_value}")
  }
  scope :with_offset,  ->(value) { with_math_field("offset", value) }
  scope :with_gain,  ->(value) { with_math_field("gain", value) }
  scope :with_expected_low,  ->(value) { with_math_field("expected_low", value) }
  scope :with_expected_high,  ->(value) { with_math_field("expected_high", value) }
  scope :with_actual_low,  ->(value) { with_math_field("actual_low", value) }
  scope :with_actual_high,  ->(value) { with_math_field("actual_high", value) }
  scope :with_reading, ->(value) { where("records_results.reading_1 #{value} or records_results.reading_2 #{value}") unless value.blank? }
  scope :with_reading_average,  ->(value) { with_math_field("reading_average", value) }
  scope :with_reading_error,  ->(value) { with_math_field("reading_error", value) }
  scope :with_reading_repeatability,  ->(value) { with_math_field("reading_repeatability", value) }
  scope :with_reading_error_valid,  ->(value) { with_boolean_field("reading_error_valid", value) }
  scope :with_reading_repeatability_valid,  ->(value) { with_boolean_field("reading_repeatability_valid", value) }
  scope :with_is_valid,  ->(value) { with_boolean_field("is_valid", value) }
  scope :with_temperature,  ->(value) { with_math_field("temperature", value) }
  scope :with_collection_amount, ->(value) { where("records_results.collection_1_amount #{value} or records_results.collection_2_amount #{value}") unless value.blank? }
  scope :with_collection_hours, ->(value) { where("records_results.collection_1_hours #{value} or records_results.collection_2_hours #{value}") unless value.blank? }
  scope :with_collection_rate, ->(value) { where("records_results.collection_1_rate #{value} or records_results.collection_2_rate #{value}") unless value.blank? }
  scope :with_collection_rate_valid,  ->(value) {
    return if value.blank?
    test_value = "FALSE"
    test_value = "TRUE" if value == true
    test_value = "TRUE" if value == "true"
    test_value = "TRUE" if value == 1
    test_value = "TRUE" if value == "1"
    where("records_results.collection_1_rate_valid IS #{test_value} or records_results.collection_2_rate_valid IS #{test_value}")
  }
  scope :with_weight,  ->(value) { with_math_field("weight", value) }
  scope :with_ph,  ->(value) { with_math_field("ph", value) }
  scope :with_salt_added,  ->(value) { with_math_field("salt_added", value) }
  scope :with_distilled_water_added,  ->(value) { with_math_field("distilled_water_added", value) }
  scope :sorted_by, ->(value) {
    case value
    when 'oldest'
      order(:result_on)
    else
      order(result_on: :desc)
    end
  }

  # Validations.
	validates	:result_on,
            presence: true

  # Callbacks.
  after_commit      :update_assignment
  after_initialize  :load_defaults

  # Instance methods.

  # Returns result details. Must be overridden in child class to provide any meaningful information.
  def details
    return "Must define <code>details</code> method in <code>/app/models/records/#{self.class.name.demodulize.underscore}.rb</code>."
  end

  # Loads default values from record type.
  def load_defaults
    return unless self.id.blank?
    return if self.record_type.blank?
    [:expected_low,
     :expected_high,
     :rockwell_scale,
     :test_block_hardness,
     :test_block_serial,
     :max_error,
     :max_repeatability].each do |attr|
      self[attr] = self.record_type[attr] unless self.record_type[attr].blank?
    end
  end

  # Updates assignment after database update.
  def update_assignment
    assignment = Records::Assignment.for_device_and_type(self.device_id, self.record_type_id).first
    return if assignment.blank?
    assignment.update_results
  end

  # Class methods.

  # Defines available methods for record type.
  def self.available_methods
    return [
      "Records::GroovTwoPointCalibration",
      "Records::HardnessTesterDailyVerification",
      "Records::SaltSprayCollectionRecord",
      "Records::IAOProbeCalibration",
      "Records::SaltSprayCabinetRecord"
    ].sort
  end

  # Returns list of available methods for record type for dropdown.
  def self.available_methods_for_dropdown
    return Records::Result.available_methods.map {|x| [x.demodulize.titleize, x]}
  end

  # Retrieves users for filter dropdown.
  def self.users
    return User.where("id in (select distinct user_id from records_results where discarded_at is null)")
  end

end