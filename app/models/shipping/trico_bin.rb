class Shipping::TricoBin < ApplicationRecord

  # Associations.
  belongs_to  :shop_order,
              class_name: 'AS400::ShopOrder'

  # Validations.
  validates :load_at, :load_number, :scale_weight,
            presence: true
  validates :load_number,
            numericality: { only_integer: true, greater_than: 0 }
  validates :scale_weight,
            numericality: { greater_than: 0 }

  # Callbacks.
  after_create  :trigger_order_calculations

  # Instance methods.

  # Returns total pieces for bin.
  def total_pieces
    return (self.proportional_pieces || 0) + (self.fudge_pieces || 0)
  end

  # Sets shop order association from shop order number.
  def shop_order_number=(value)
    self.shop_order = AS400::ShopOrder.from_as400(value)
  end

  # Calls method in parent shop order to perform calculations.
  def trigger_order_calculations
    self.shop_order.calculate_trico_bin_labels
  end

end