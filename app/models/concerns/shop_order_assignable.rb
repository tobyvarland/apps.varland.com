module ShopOrderAssignable

  extend ActiveSupport::Concern

  # Sets shop order association from shop order number.
  def shop_order_number=(value)
    self.shop_order = AS400::ShopOrder.from_as400(value)
  end

end