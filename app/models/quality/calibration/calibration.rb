class Quality::Calibration::Calibration < ApplicationRecord
  
  # Associations.
  belongs_to  :device,
              class_name: 'Quality::Calibration::Device'
  belongs_to  :user,
              class_name: '::User'
  belongs_to  :reason_code,
              class_name: 'Quality::Calibration::ReasonCode'

  # Soft deletes.
  include Discard::Model
  default_scope -> { kept }

  # Scopes.

  # Validations.
  validates :calibrated_on,
            presence: true   
  validate  :ensure_calibration_date_not_in_future
            
  # Instance Methods

  def description
    return "override in child class"
  end

  # Ensures in service date not in future.
  def ensure_calibration_date_not_in_future
    return if self.calibrated_on.blank?
    errors.add(:calibrated_on, "cannot be in the future") if self.calibrated_on > Date.current
  end

  # Class Methods.

  # Define calibration options for categories.
  def self.calibration_method_options
    return [
      ["Groov Two Point Calibration", "Quality::Calibration::GroovTwoPointCalibration"]
    ]
  end


end