class Quality::Calibration::ReasonCode < ApplicationRecord

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

