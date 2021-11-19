class Quality::Calibration::Device < ApplicationRecord
  belongs_to :category

  # Soft deletes.
  include Discard::Model
  default_scope -> { kept }

  # Scopes.

  # Validations.
  validates :name, 
            presence: true,
            uniqueness: { scope: :category_id, case_sensitive: false }
  validates :in_service_on,
            presence: true   

end