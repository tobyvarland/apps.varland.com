module ShopOrderAssignable

  extend ActiveSupport::Concern

  # Sets shop order association from shop order number.
  def shop_order_number=(value)
    self.shop_order = AS400::ShopOrder.from_as400(value)
  end

  # Returns shop order number.
  def shop_order_number
    return nil unless self.shop_order.present?
    return self.shop_order.number
  end

end