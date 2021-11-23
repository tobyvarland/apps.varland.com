class Quality::Calibration::ReasonCode < ApplicationRecord

  # Associations.
  has_many    :results,
              class_name: 'Quality::Calibration::Result',
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

