class Projects::System < ApplicationRecord

  # Friendly ID.
  extend FriendlyId
  friendly_id :abbreviation

  # Soft Deletes.
  include Discard::Model
  default_scope -> { kept }

  # Assocations.
  has_many  :categories,
            class_name: "Projects::Category",
            foreign_key: "system_id",
            inverse_of: :system,
            dependent: :restrict_with_error
  has_many  :items,
            class_name: "Projects::Item",
            through: :categories

  # Validations.
  validates	:name,
            presence: true,
            uniqueness: { case_sensitive: false }
  validates	:abbreviation,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: /\A[a-z0-9_]+\z/ },
            length: { in: 2..15 }

  # Scopes.
  default_scope -> { order(:name) }

end