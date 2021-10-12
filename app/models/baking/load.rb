class Baking::Load < ApplicationRecord

  # Associations.
  belongs_to  :order,
              class_name: "Baking::Order"
  has_many    :containers,
              class_name: "Baking::Container",
              inverse_of: :load,
              dependent: :nullify

  # Scopes.
  scope :by_number, -> { order(:number, :is_rework) }

  # Validations.
  validates :number,
            presence: true,
            numericality: { only_integer: true, greater_than: 0 },
            uniqueness: { scope: [:order_id, :is_rework] }
  validate  :require_cycle_not_baking

  # Instance methods.

  # Don't allow order creation once cycle starts baking.
  def require_cycle_not_baking
    errors.add(:base, "Bake cycle already started, can't add load") if self.order.cycle.has_started_baking?
  end

  # Returns load description.
  def description
    return "#{self.number}#{self.is_rework ? "*" : ""}"
  end

end