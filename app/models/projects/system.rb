class Projects::System < ApplicationRecord

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