class Groov::Bake::PlatedLoad < ApplicationRecord

  # Concerns.
  include ShopOrderAssignable

  # Associations.
  belongs_to  :as400_shop_order,
              class_name: 'AS400::ShopOrder',
              foreign_key: "as400_shop_order_id"
  belongs_to  :load,
              class_name: "Groov::Bake::Load",
              foreign_key: "load_id",
              inverse_of: :plated_load,
              optional: true

  # Validations.
  validates :number, :department,
            presence: true,
            numericality: { only_integer: true, greater_than: 0 }
  validates :out_of_plating_at,
            presence: true

  # Scopes.

  # Callbacks.
  before_validation :initialize_timestamp

  # Instance methods.

  # Returns whether plated load met bake within spec.
  def met_spec?
    ttl = self.time_to_load
    return nil if ttl.nil?
    return ttl <= (self.bake_within / 60.0)
  end

  # Returns time to load in hours.
  def time_to_load
    return nil if self.load.blank?
    return (self.load.in_oven_at - self.out_of_plating_at) / 1.hours
  end

  # Sets timestamp if not already set.
  def initialize_timestamp
    self.out_of_plating_at = Time.current if self.out_of_plating_at.blank?
  end

  # Class methods.

end