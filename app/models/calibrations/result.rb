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
  scope :for_device_and_type, ->(device, type) { where(device_id: device).where(calibration_type_id: type) }
  scope :for_type, ->(type) { where(calibration_type_id: type) }
  scope :reverse_chronological, -> { order(result_on: :desc) }

  # Validations.
	validates	:result_on,
            presence: true

  # Callbacks.
  after_commit  :update_assignment

  # Instance methods.

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
      "Calibrations::GenericCalibration"
    ].sort
  end

  # Returns list of available methods for calibration type for dropdown.
  def self.available_methods_for_dropdown
    return Calibrations::Result.available_methods.map {|x| [x.demodulize.titleize, x]}
  end

end