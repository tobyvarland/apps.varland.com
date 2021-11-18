class Quality::Calibration::ReasonCode < ApplicationRecord

  # Soft deletes.
  include Discard::Model
  default_scope -> { kept }

  # Validations.
  validates :name,
            presence: true

end

