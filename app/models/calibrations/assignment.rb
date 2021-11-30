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

  # Instance methods.

  # Class methods.

end