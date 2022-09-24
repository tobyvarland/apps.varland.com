class Bake::Container < ApplicationRecord

  # Associations.
  belongs_to  :stand
  has_many  :loadings,
            inverse_of: 'container',
            foreign_key: 'container_id'
  has_many  :loads,
            through: :loadings

  # Validations.
  validates :number,
            presence: true,
            numericality: { only_integer: true, greater_than: 0 },
            uniqueness: { scope: :stand_id }

end