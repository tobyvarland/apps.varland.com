class Calibrations::ReasonCode < ApplicationRecord

  # Soft deletes.
  include Discard::Model
  default_scope -> { kept }

	# Associations.
	has_many	:results,
						class_name: "Calibrations::Result",
						foreign_key: "reason_code_id",
						inverse_of: :reason_code,
						dependent: :restrict_with_error

  # Scopes.
	default_scope -> { by_name }
  scope :by_name, -> { order(:name) }

  # Validations.
	validates	:name,
						presence: true,
						uniqueness: { case_sensitive: false }

	# Instance methods.

	# Class methods.

end