class Records::Device < ApplicationRecord

  # Soft deletes.
  include Discard::Model
  default_scope -> { kept }

	# Associations.
	has_many	:assignments,
						class_name: "Records::Assignment",
						foreign_key: "device_id",
						inverse_of: :device,
						dependent: :destroy
	has_many	:results,
						class_name: "Records::Result",
						foreign_key: "device_id",
						inverse_of: :device,
						dependent: :restrict_with_error

	# Nested attributes.
	accepts_nested_attributes_for :assignments, reject_if: :all_blank, allow_destroy: true

  # Scopes.
  scope :by_name, -> { order(:name) }
	scope :not_retired, -> { where(retired_on: nil) }

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