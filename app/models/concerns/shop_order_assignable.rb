module ShopOrderAssignable

  extend ActiveSupport::Concern

  # Define common scopes for shop order assignable objects.
  included do
    scope :with_shop_order_field, ->(field, value) { joins(:shop_order).where("`as400_shop_orders`.`#{field}` = ?", value) unless value.blank? }
    scope :with_shop_order, ->(value) { with_shop_order_field("number", value) }
    scope :with_part, ->(value) { with_shop_order_field("part", value) }
    scope :with_process_code, ->(value) { with_shop_order_field("process_code", value) }
    scope :with_customer, ->(value) { with_shop_order_field("customer_code", value) }
    scope :with_customer_code, ->(value) { with_shop_order_field("customer_code", value) }
    scope :by_part_spec, -> { joins(:shop_order).order("`as400_shop_orders`.`customer_code`, `as400_shop_orders`.`process_code`, `as400_shop_orders`.`part`, `as400_shop_orders`.`sub`, `as400_shop_orders`.`number`") }
    scope :by_shop_order, -> { joins(:shop_order).order("`as400_shop_orders`.`number`") }
  end

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