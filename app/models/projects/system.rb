class Projects::System < ApplicationRecord
  
  # Soft Deletes.
  include Discard::Model
  default_scope -> { kept }

  # Assocations.
  has_many  :categories,
            class_name: "Projects::Category",
            foreign_key: "system_id",
            inverse_of: :system,
            dependent: :restrict_with_error

  # Validations.
  validates	:name,
            presence: true,
            uniqueness: { case_sensitive: false }
  validates	:abbreviation,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: /\A[a-z0-9_]+\z/ },
            length: { in: 2..15 }          

end