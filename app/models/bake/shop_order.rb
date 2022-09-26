class Bake::ShopOrder < ApplicationRecord

  # Associations.
  belongs_to :cycle
  has_many  :loads,
            inverse_of: 'shop_order',
            foreign_key: 'shop_order_id'

  # Validations.
  validates :number, :customer, :process, :part, :operation, :setpoint, :minimum, :maximum, :soak_hours,
            presence: true
  validates :number,
            uniqueness: { scope: 'cycle_id' }
  validates :number, :setpoint, :minimum, :maximum,
            numericality: { only_integer: true, greater_than: 0 },
            allow_blank: true
  validates :soak_hours, :within_hours,
            numericality: { greater_than: 0 },
            allow_blank: true
  validate  :ensure_cycle_fit
  validate  :ensure_unlocked_cycle
  validate  :verify_profile_name_presence

  # Callbacks.
  before_validation :set_properties_for_manual_shop_order
  after_save        :set_cycle_profile_name

  # Instance methods.

  # Verifies profile name is present if required.
  def verify_profile_name_presence
    errors.add(:profile_name, "must be present for this cycle type") if self.profile_name.blank? && self.cycle.class::REQUIRES_BAKE_PROFILE
    errors.add(:profile_name, "can't be present for this cycle type") if !self.profile_name.blank? && !self.cycle.class::REQUIRES_BAKE_PROFILE
  end

  # Custom validation method to ensure cycle is not locked.
  def ensure_unlocked_cycle
    errors.add(:base, "Cycle is locked, so cannot add any orders to it.") if self.cycle.is_locked
  end

  # Custom validation method to ensure order fits with any other orders on cycle.
  def ensure_cycle_fit

    # Exit if cycle doesn't have any other orders.
    return if self.cycle.shop_orders.where.not(id: self.id).length == 0

    # Add error if cycle has profile name but this order doesn't match.
    errors.add(:profile_name, "must match all other orders in cycle") if !self.cycle.profile_name.blank? && self.cycle.profile_name != self.profile_name

    # Ensure temperatures fit with other orders.
    cycle_minimum = self.cycle.shop_orders.where.not(id: self.id).maximum(:minimum)
    cycle_maximum = self.cycle.shop_orders.where.not(id: self.id).minimum(:maximum)
    proposed_minimum = [cycle_minimum, self.minimum].max
    proposed_maximum = [cycle.maximum, self.maximum].min
    proposed_range = proposed_maximum - proposed_minimum
    errors.add(:base, "Baking parameters are incompatible with other orders in cycle.") unless proposed_range >= 10

  end

  # Sets properties for manual shop order.
  def set_properties_for_manual_shop_order
    return unless self.number == 111
    self.customer = "X" * 6
    self.process = "X" * 3
    self.part = "X" * 17
    self.sub = "X"
    self.operation = "X"
  end

  # Sets profile name on cycle if necessary.
  def set_cycle_profile_name
    return if self.profile_name.blank? || !self.cycle.profile_name.blank?
    self.cycle.update(profile_name: self.profile_name)
  end

end