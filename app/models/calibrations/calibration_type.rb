class Calibrations::CalibrationType < ApplicationRecord

  # Soft deletes.
  include Discard::Model
  default_scope -> { kept }

	# Associations.
	has_many	:assignments,
						class_name: "Calibrations::Assignment",
						foreign_key: "calibration_type_id",
						inverse_of: :calibration_type,
						dependent: :destroy
	has_many	:results,
						class_name: "Calibrations::Result",
						foreign_key: "calibration_type_id",
						inverse_of: :calibration_type,
						dependent: :restrict_with_error
	has_many	:devices,
						through: :assignments

	# Nested attributes.
	accepts_nested_attributes_for :assignments, reject_if: :all_blank, allow_destroy: true

  # Scopes.
	default_scope -> { by_name }
  scope :by_name, -> { order(:name) }

  # Validations.
	validates	:name,
						presence: true,
						uniqueness: { case_sensitive: false }
	validates	:frequency,
						numericality: { only_integer: true, greater_than: 0 },
						allow_blank: true
	validates :calibration_method,
						inclusion: { in: Calibrations::Result.available_methods }

	# Callbacks.

	# Instance methods.

	# Class methods.

end