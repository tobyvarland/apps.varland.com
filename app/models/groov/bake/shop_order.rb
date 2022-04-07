class Groov::Bake::ShopOrder < ApplicationRecord

  # Concerns.
  include ShopOrderAssignable

  # Enumerations.
  enum container_type: {
    trays: 1,
    rods: 2
  }, _prefix: true

  # Associations.
  belongs_to  :as400_shop_order,
              class_name: 'AS400::ShopOrder',
              foreign_key: "as400_shop_order_id"
  belongs_to  :cycle,
              class_name: "Groov::Bake::Cycle",
              foreign_key: "cycle_id",
              inverse_of: :shop_orders
  has_many	:loads,
            class_name: "Groov::Bake::Load",
            foreign_key: "shop_order_id",
            inverse_of: :shop_order,
            dependent: :destroy
  has_many	:containers,
            class_name: "Groov::Bake::Container",
            through: :loads

  # Validations.
  validates :container_type,
            presence: true
  validates :as400_shop_order_id,
            uniqueness: { scope: :cycle_id }
  validates :setpoint, :minimum, :maximum, :soak_length,
            presence: true,
            numericality: { only_integer: true, greater_than: 0 }
  validates :bake_within,
            presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # Scopes.

  # Callbacks.
  after_save  :update_cycle_bake_parameters

  # Instance methods.

  # Update cycle bake parameters if first order on cycle.
  def update_cycle_bake_parameters
    self.cycle.update_parameters
  end

  # Class methods.

end