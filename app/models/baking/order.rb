class Baking::Order < ApplicationRecord

  # Associations.
  belongs_to  :cycle,
              class_name: "Baking::Cycle"
  belongs_to  :process_code,
              class_name: "Baking::ProcessCode",
              optional: true
  has_many    :loads,
              class_name: "Baking::Load",
              inverse_of: :order,
              dependent: :destroy

  # Validations.
  validates :number,
            presence: true,
            numericality: { only_integer: true, greater_than: 0 },
            uniqueness: { scope: :cycle_id }
  validates :customer, :process, :part,
            presence: true
  validates :minimum, :maximum, :setpoint, :soak_length,
            numericality: { only_integer: true, greater_than: 0 },
            allow_blank: true
  validate  :require_baking_params_unless_standard_procedure
  validate  :require_profile_name_if_iao_oven
  validate  :baking_params_fit_cycle
  validate  :require_cycle_not_baking

  # Callbacks.
  before_validation :nullify_blanks

  # Instance methods.

  # Don't allow order creation once cycle starts baking.
  def require_cycle_not_baking
    errors.add(:base, "Bake cycle already started, can't add order") if self.cycle.has_started_baking?
  end

  # Validates that baking params for this order work with the other orders on the cycle.
  def baking_params_fit_cycle
    return if !self.cycle.procedure_id.blank? || self.cycle.orders.length == 0
    case self.cycle.oven_type.is_iao
    when true
      errors.add(:profile_name, "does not match other orders on this cycle") if self.profile_name != self.cycle.profile_name
    when false
      return if self.minimum.blank? || self.maximum.blank?
      new_minimum = [self.cycle.minimum, self.minimum].max
      new_maximum = [self.cycle.maximum, self.maximum].min
      errors.add(:base, "Baking parameters not valid on this cycle") if (new_maximum - new_minimum < 10)
    end
  end

  # Nullifies fields with empty strings.
  def nullify_blanks
    self.sub = nil if self.sub.blank?
    self.operation_letter = nil if self.operation_letter.blank?
    self.profile_name = nil if self.profile_name.blank?
  end

  # Requires profile name if using IAO oven.
  def require_profile_name_if_iao_oven
    return if self.cycle_id.blank? || !self.cycle.procedure_id.blank? || !self.cycle.oven_type.is_iao
    errors.add(:profile_name, "can't be blank") if self.profile_name.blank?
  end

  # Requires standard params unless cycle using standard procedure.
  def require_baking_params_unless_standard_procedure
    return if self.cycle_id.blank? || !self.cycle.procedure_id.blank?
    errors.add(:operation_letter, "can't be blank") if self.operation_letter.blank?
    errors.add(:minimum, "can't be blank") if self.minimum.blank?
    errors.add(:maximum, "can't be blank") if self.maximum.blank?
    errors.add(:setpoint, "can't be blank") if self.setpoint.blank?
    errors.add(:soak_length, "can't be blank") if self.soak_length.blank?
  end

end