class Groov::Bake::Container < ApplicationRecord

  # Enumerations.
  enum oven_shelf_tray_position: {
    back_left: 1,
    back_center: 2,
    back_right: 3,
    front_left: 4,
    front: 5,
    front_right: 6
  }, _prefix: true

  # Associations.
  belongs_to  :load,
              class_name: "Groov::Bake::Load",
              foreign_key: "load_id",
              inverse_of: :containers

  # Validations.
  validates :description,
            presence: true
  validates :bakestand_column, :bakestand_row, :rod_cart_shelf, :rod_cart_position, :oven_shelf, :oven_shelf_tray_position, :oven_shelf_rod_position,
            numericality: { only_integer: true, greater_than: 0 },
            allow_blank: true

  # Scopes.

  # Callbacks.

  # Instance methods.

  # Returns loading description for tray.
  def tray_loading
    return "#{self.load.shop_order.as400_shop_order.number} » #{self.load.number_and_indicator}"
  end

  # Returns loading description for rod.
  def rod_loading
    return "#{self.load.shop_order.as400_shop_order.number % 1000}\n#{self.load.number_and_indicator}"
  end

  # Class methods.

end