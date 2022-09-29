class Bake::Cycle < ApplicationRecord

  # Class constants.
  REQUIRES_BAKE_PROFILE = nil

  # Scopes.
  scope :not_started, -> { where(is_locked: false) }

  # Associations.
  belongs_to  :user,
              optional: true
  has_many  :stands,
            inverse_of: 'cycle',
            foreign_key: 'cycle_id'
  has_many  :shop_orders,
            inverse_of: 'cycle',
            foreign_key: 'cycle_id'
  has_many  :loads,
            through: :shop_orders
  has_many  :loadings,
            through: :loads

  # Nested attributed.
  accepts_nested_attributes_for :stands,
                                reject_if: proc { |attributes| attributes['name'].blank? }

  # Instance methods.

  # Creates a large stand with a specific name.
  def large_stand=(value)
    Bake::LargeStand.create(cycle: self, name: value)
  end

  # Creates a small stand with a specific name.
  def small_stand=(value)
    Bake::SmallStand.create(cycle: self, name: value)
  end

  # Creates a rod cart with a specific name.
  def rod_cart=(value)
    Bake::RodCart.create(cycle: self, name: value)
  end

  # Returns whether or not cycle is ready to bake (valid for loading in Opto).
  def ready_to_bake?

    # Initialize error message.
    msg = nil

    # Return false if cycle has no stands or orders.
    msg = "No stands added to cycle." if self.stands.length == 0
    msg = "No shop orders added to cycle." if self.shop_orders.length == 0

    # Return false if any shop order does not have loads.
    self.shop_orders.each do |shop_order|
      msg = "Cycle contains order(s) without loads." if shop_order.loads.length == 0
    end

    # Return false if any load not placed in container.
    self.loads.each do |load|
      msg = "Cycle contains load(s) without container specified." if load.loadings.length == 0
    end

    # Return error message or true.
    return msg.nil? ? true : msg

  end

  # Sets timestamp for all "loaded" loads.
  def set_load_timestamps
    current = Time.current
    self.loads.where(not_loaded: false).where(started_baking_at: nil).each do |load|
      load.update(started_baking_at: current)
    end
  end

  # Returns cycle minimum temperature.
  def minimum
    return nil if self.shop_orders.length == 0
    return self.shop_orders.maximum(:minimum)
  end

  # Returns cycle maximum temperature.
  def maximum
    return nil if self.shop_orders.length == 0
    return self.shop_orders.minimum(:maximum)
  end

  # Returns cycle setpoint.
  def setpoint
    return nil if self.shop_orders.length == 0
    return (self.minimum + self.maximum) / 2.0
  end

  # Returns cycle soak length
  def soak_hours
    return nil if self.shop_orders.length == 0
    return self.shop_orders.maximum(:soak_hours)
  end

  # Returns cycle type.
  def cycle_type
    return self.type.demodulize.underscore.titleize.sub(" Cycle", "")
  end

end