class Groov::Baking::ShopOrder < ApplicationRecord

  # Concerns.
  include ShopOrderAssignable

  # Associations.
  belongs_to  :shop_order,
              class_name: 'AS400::ShopOrder'
  belongs_to  :cycle,
              class_name: "Groov::Baking::Cycle",
              foreign_key: "cycle_id",
              inverse_of: :shop_orders
  has_many	:loads,
            class_name: "Groov::Baking::Load",
            foreign_key: "shop_order_id",
            inverse_of: :shop_order,
            dependent: :destroy

  # Validations.
  validate :require_iao_bake_parameters
  validate :require_iao_parameter_match

  # Callbacks.
  after_save  :update_cycle_bake_parameters

  # Instance methods.

  # Retrieves string of load numbers.
  def load_numbers
    loads = self.loads.order(:number, :is_rework).map {|l| l.load_number }
    case loads.length
    when 1
      return loads[0]
    when 2
      return loads.join(" & ")
    else
      return loads.join(", ")
    end
  end

  # Update cycle bake parameters if first order on cycle.
  def update_cycle_bake_parameters
    return unless self.cycle.profile_name.blank?
    self.cycle.profile_name = self.shop_order.iao_profile
    self.cycle.setpoint = self.shop_order.iao_setpoint
    self.cycle.minimum = self.shop_order.iao_minimum
    self.cycle.maximum = self.shop_order.iao_maximum
    self.cycle.soak_length = self.shop_order.iao_soak_length
    self.cycle.save
  end

  # Requires shop order with IAO baking parameters.
  def require_iao_bake_parameters
    errors.add(:base, "Shop order in invalid") if self.shop_order.blank?
    errors.add(:base, "Shop order doesn't have IAO baking parameters") if self.shop_order.iao_profile.blank?
  end

  # Requires IAO bake parameters to match cycle.
  def require_iao_parameter_match
    errors.add(:base, "Shop order in invalid") if self.shop_order.blank?
    return if self.cycle.profile_name.blank?
    errors.add(:base, "Shop order bake parameters don't match cycle") if self.shop_order.iao_profile != self.cycle.profile_name
  end

end