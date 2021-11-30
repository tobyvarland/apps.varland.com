class Calibrations::Result < ApplicationRecord

  # Soft deletes.
  include Discard::Model
  default_scope -> { kept }

  # Associations.
  belongs_to  :device,
              class_name: "Calibrations::Device",
              foreign_key: "device_id",
              inverse_of: :results
  belongs_to  :calibration_type,
              class_name: "Calibrations::CalibrationType",
              foreign_key: "calibration_type_id",
              inverse_of: :results
  belongs_to  :user,
              class_name: "::User",
              foreign_key: "user_id"
  belongs_to  :reason_code,
              class_name: "Calibrations::ReasonCode",
              foreign_key: "reason_code_id",
              inverse_of: :results

  # Scopes.
  scope :kept, -> { undiscarded.joins(:calibration_type).joins(:device).merge(Calibrations::CalibrationType.kept).merge(Calibrations::Device.kept) }
  scope :for_device_and_type, ->(device, type) { where(device_id: device).where(calibration_type_id: type) }
  scope :for_calibration_type, ->(value) { where(calibration_type_id: value) unless value.blank? }
  scope :for_device, ->(value) { where(device_id: value) unless value.blank? }
  scope :for_reason_code, ->(value) { where(reason_code_id: value) unless value.blank? }
  scope :for_user, ->(value) { where(user_id: value) unless value.blank? }
  scope :reverse_chronological, -> { order(result_on: :desc) }
  scope :on_or_after, ->(value) { where("result_on >= ?", value) unless value.blank? }
  scope :on_or_before,  ->(value) { where("result_on <= ?", value) unless value.blank? }
  scope :with_math_field, ->(field, value) { where("calibrations_results.#{field} #{value}") unless value.blank? }
  scope :with_offset,  ->(value) { with_math_field("offset", value) }
  scope :with_gain,  ->(value) { with_math_field("gain", value) }
  scope :with_expected_low,  ->(value) { with_math_field("expected_low", value) }
  scope :with_expected_high,  ->(value) { with_math_field("expected_high", value) }
  scope :with_actual_low,  ->(value) { with_math_field("actual_low", value) }
  scope :with_actual_high,  ->(value) { with_math_field("actual_high", value) }
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
    return "Must define <code>details</code> method in <code>/app/models/calibrations/#{self.class.name.demodulize.underscore}.rb</code>."
  end

  # Loads default values from calibration type.
  def load_defaults
    return unless self.id.blank?
    return if self.calibration_type.blank?
    [:expected_low,
     :expected_high,
     :rockwell_scale,
     :test_block_hardness,
     :test_block_serial,
     :max_error,
     :max_repeatability].each do |attr|
      self[attr] = self.calibration_type[attr] unless self.calibration_type[attr].blank?
    end
  end

  # Updates assignment after database update.
  def update_assignment
    assignment = Calibrations::Assignment.for_device_and_type(self.device_id, self.calibration_type_id).first
    return if assignment.blank?
    assignment.update_results
  end

  # Class methods.

  # Defines available methods for calibration type.
  def self.available_methods
    return [
      "Calibrations::GroovTwoPointCalibration",
      "Calibrations::HardnessTesterDailyVerification",
      "Calibrations::SaltSprayCollectionRecord"
    ].sort
  end

  # Returns list of available methods for calibration type for dropdown.
  def self.available_methods_for_dropdown
    return Calibrations::Result.available_methods.map {|x| [x.demodulize.titleize, x]}
  end

  # Retrieves users for filter dropdown.
  def self.users
    return User.where("id in (select distinct user_id from calibrations_results where discarded_at is null)")
  end

end