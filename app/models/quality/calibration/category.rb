class Quality::Calibration::Category < ApplicationRecord

  # Soft deletes.
  include Discard::Model
  default_scope -> { kept }

  # Scopes.
  default_scope -> { order(:name) }

  # Validations.
  validates :name, 
            presence: true,
            uniqueness: { case_sensitive: false }
  validates :calibration_frequency,
            presence: true,
            numericality: { only_integer: true, greater_than: 0 }
  validates :two_point_low_value, :two_point_high_value,
            numericality: { greater_than: 0 },
            allow_blank: true
  
end
