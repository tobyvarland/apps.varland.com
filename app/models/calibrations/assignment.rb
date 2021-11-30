class Calibrations::Assignment < ApplicationRecord

  # Soft deletes.
  include Discard::Model
  default_scope -> { kept }

  # Associations.
  belongs_to  :device,
              class_name: "Calibrations::Device",
              foreign_key: "device_id",
              inverse_of: :assignments
  belongs_to  :calibration_type,
              class_name: "Calibrations::CalibrationType",
              foreign_key: "calibration_type_id",
              inverse_of: :assignments

  # Scopes.

  # Validations.

  # Callbacks.
  before_create :initialize_due_date

  # Instance methods.

  # Initialize due date.
  def initialize_due_date
    return if self.calibration_type.blank?
    unless self.calibration_type.frequency.blank?
      self.next_result_due_on = Date.current
      self.next_result_due_in_days = 0
    end
  end

  # Class methods.

end