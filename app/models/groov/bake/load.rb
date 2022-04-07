class Groov::Bake::Load < ApplicationRecord

  # Associations.
  belongs_to  :shop_order,
              class_name: "Groov::Bake::ShopOrder",
              foreign_key: "shop_order_id",
              inverse_of: :loads
  has_one :plated_load,
          class_name: "Groov::Bake::PlatedLoad",
          foreign_key: "load_id",
          inverse_of: :load
  has_many	:containers,
            class_name: "Groov::Bake::Container",
            foreign_key: "load_id",
            inverse_of: :load,
            dependent: :destroy

  # Validations.
  validates :number, :container_count,
            presence: true,
            numericality: { only_integer: true, greater_than: 0 }

  # Scopes.

  # Callbacks.
  after_create  :create_containers

  # Instance methods.

  # Returns number and rework indicator.
  def number_and_indicator
    return "#{self.number}#{"RW" if self.is_rework}"
  end

  # Creates containers for load.
  def create_containers
    base = case self.shop_order.container_type
           when "trays" then "Tray"
           when "rods" then "Rod"
           else nil
           end
    return if base.blank?
    1.upto(self.container_count) do |i|
      self.containers.create(description: "#{base} #{i} of #{self.container_count}")
    end
  end

  # Class methods.

end