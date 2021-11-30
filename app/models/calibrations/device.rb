class Calibrations::Device < ApplicationRecord

  # Soft deletes.
  include Discard::Model
  default_scope -> { kept }

	# Associations.
	has_many	:assignments,
						class_name: "Calibrations::Assignment",
						foreign_key: "device_id",
						inverse_of: :device,
						dependent: :destroy
	has_many	:results,
						class_name: "Calibrations::Result",
						foreign_key: "device_id",
						inverse_of: :device,
						dependent: :restrict_with_error

	# Nested attributes.
	accepts_nested_attributes_for :assignments, reject_if: :all_blank, allow_destroy: true

  # Scopes.
	default_scope -> { by_name }
  scope :by_name, -> { order(:name) }

  # Validations.
	validates	:name,
						presence: true,
						uniqueness: { case_sensitive: false }
	validates	:in_service_on,
						presence: true

	# Callbacks.

  # Instance methods.

  # Class methods.

end