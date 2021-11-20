class Quality::Calibration::ReasonCode < ApplicationRecord

  # Associations.
  has_many    :calibrations, 
              class_name: 'Quality::Calibration::Calibrations', 
              foreign_key: 'reason_code_id'

  # Soft deletes.
  include Discard::Model
  default_scope -> { kept }

  # Scopes.
  default_scope -> { order(:name) }

  # Validations.
  validates :name,
            presence: true,
            uniqueness: { case_sensitive: false }

end

