class Bake::Load < ApplicationRecord

  # Associations.
  belongs_to :shop_order
  delegate  :cycle,
            to: :shop_order,
            allow_nil: true
  has_many  :loadings,
            inverse_of: 'load',
            foreign_key: 'load_id'
  has_many  :containers,
            through: :loadings

  # Validations.
  validates :number,
            presence: true,
            numericality: { only_integer: true, greater_than: 0 },
            uniqueness: { scope: 'shop_order_id' }

end