class Bake::Container < ApplicationRecord

  # Associations.
  belongs_to  :stand

  # Validations.
  validates :number,
            presence: true,
            numericality: { only_integer: true, greater_than: 0 },
            uniqueness: { scope: :stand_id }

end