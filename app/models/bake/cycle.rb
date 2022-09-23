class Bake::Cycle < ApplicationRecord

  # Associations.
  belongs_to  :user,
              optional: true

  # Validations.
  validates :type,
            presence: true

end