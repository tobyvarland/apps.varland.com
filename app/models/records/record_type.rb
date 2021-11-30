class Records::RecordType < ApplicationRecord

  # Soft deletes.
  include Discard::Model
  default_scope -> { kept }

	# Associations.
	has_many	:assignments,
						class_name: "Records::Assignment",
						foreign_key: "record_type_id",
						inverse_of: :record_type,
						dependent: :destroy
	has_many	:results,
						class_name: "Records::Result",
						foreign_key: "record_type_id",
						inverse_of: :record_type,
						dependent: :restrict_with_error

	# Nested attributes.
	accepts_nested_attributes_for :assignments, reject_if: :all_blank, allow_destroy: true

  # Scopes.
  scope :by_name, -> { order(:name) }

  # Validations.
	validates	:name,
						presence: true,
						uniqueness: { case_sensitive: false }
	validates	:frequency,
						numericality: { only_integer: true, greater_than: 0 },
						allow_blank: true
	validates :calibration_method,
						inclusion: { in: Records::Result.available_methods }
	validates	:expected_low,
						:expected_high,
						numericality: true,
						allow_blank: true

	# Callbacks.
	after_update_commit	:update_assignment_dates

	# Instance methods.

	# Updates assignment dates when frequency changes.
	def update_assignment_dates
		return unless self.discarded_at.blank?
		self.assignments.each do |assignment|
			assignment.set_next_due_date
			assignment.save
		end
	end

	# Returns devices for dropdown.
	def devices_for_dropdown
		return self.assignments.map {|a| [a.device.name, a.device_id]}
	end

	# Class methods.

end