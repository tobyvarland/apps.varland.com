class Records::RecordType < ApplicationRecord

	# Friendly ID.
	extend FriendlyId
  friendly_id :name, use: :slugged

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
	scope :with_frequency, -> { where.not(frequency: nil) }
  scope :for_data_type, ->(value) { where(data_type: value) unless value.blank? }
  scope :for_responsibility, ->(value) { where(responsibility: value) unless value.blank? }

  # Validations.
	validates	:name,
						presence: true,
						uniqueness: { case_sensitive: false }
	validates	:frequency,
						numericality: { only_integer: true, greater_than: 0 },
						allow_blank: true
	validates :record_subclass,
						inclusion: { in: Records::Result.available_methods }
	validates	:expected_low,
						:expected_high,
						numericality: true,
						allow_blank: true
	validates :data_type,
						:responsibility,
						presence: true
	validate	:match_calibration_in_name_and_data_type

	# Callbacks.
	after_update_commit	:update_assignment_dates

	# Instance methods.

	# Require matching calibration in name and data type.
	def match_calibration_in_name_and_data_type
		errors.add(:name, "must include 'Calibration' if calibration data type is selected") if self.data_type == 'calibration' && !self.name.downcase.include?("calibration")
		errors.add(:data_type, "must be 'Calibration' because the name contains the word calibration") if self.data_type != 'calibration' && self.name.downcase.include?("calibration")
	end

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
		return self.assignments.for_active_device.by_device.map {|a| [a.device.name, a.device_id]}
	end

	# Returns whether or not has YouTube video.
	def has_youtube_video?
		return self.url.match?(/\Ahttps:\/\/www\.youtube\.com\/watch\?v=(\w+)\z/)
	end

	# Returns YouTube embed URL.
	def youtube_embed_url
		matches = self.url.match(/\Ahttps:\/\/www\.youtube\.com\/watch\?v=(\w+)\z/)
		return "https://www.youtube.com/embed/#{matches[1]}?rel=0"
	end

	# Class methods.

	# Define data types for dropdown.
	def self.available_data_types
		return [
			["Calibration", "calibration"],
			["Internal Metric", "internal_metric"],
			["IT Function", "it_function"]
		].sort
	end

	# Define responsibilities for dropdown.
	def self.available_responsibilities
		return [
			["QC", "qc"],
			["Lab", "lab"],
			["Maintenance", "maintenance"],
			["IT", "it"],
			["Shipping", "shipping"]
		].sort
	end

end