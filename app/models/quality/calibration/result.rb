class Quality::Calibration::Result < ApplicationRecord

  # Associations.
  belongs_to  :device,
              class_name: 'Quality::Calibration::Device',
              touch: :results_updated_at
  belongs_to  :user,
              class_name: '::User'
  belongs_to  :reason_code,
              class_name: 'Quality::Calibration::ReasonCode'

  # Soft deletes.
  include Discard::Model
  default_scope -> { kept }

  # Scopes.
  scope :sorted_by, ->(value) {
    case value
    when "oldest"
      order(:calibrated_on)
    else
      order(calibrated_on: :desc)
    end
  }

  # Validations.
  validates :calibrated_on,
            presence: true
  validate  :ensure_calibration_date_not_in_future

  # Callbacks.
  after_commit    :update_device_calibration_details

  # Instance methods.

  # Instructs device to update details.
  def update_device_calibration_details
    self.device.store_calibration_details
  end

  # Description of individual calibration. Must be overridden in child class.
  def description
    return "override in child class"
  end

  # Ensures in service date not in future.
  def ensure_calibration_date_not_in_future
    return if self.calibrated_on.blank?
    errors.add(:calibrated_on, "cannot be in the future") if self.calibrated_on > Date.current
  end

  # Class methods.

  # Define calibration options for categories.
  def self.calibration_method_options
    return [
      ["Groov Two Point Calibration", "Quality::Calibration::GroovTwoPointCalibration"]
    ]
  end


end