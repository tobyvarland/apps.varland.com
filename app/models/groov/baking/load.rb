class Groov::Baking::Load < ApplicationRecord

  # Associations.
  belongs_to  :shop_order,
              class_name: "Groov::Baking::ShopOrder",
              foreign_key: "shop_order_id",
              inverse_of: :loads

  # Validations.
  validates :number,
            presence: true,
            numericality: { only_integer: true, greater_than: 0 },
            uniqueness: { scope: [:shop_order_id, :is_rework] }

  # Instance methods.

  # Returns load number with rework indicator.
  def load_number
    return "#{self.number}#{self.is_rework ? "RW" : ""}"
  end

end