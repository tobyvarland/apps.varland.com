class Baking::Container < ApplicationRecord

  # Associations.
  belongs_to  :load,
              class_name: "Baking::Load",
              optional: true
  belongs_to  :cycle,
              class_name: "Baking::Cycle"

  # Scopes.
  default_scope { order(:position) }

  # Validations.
  validate  :require_cycle_not_baking
  validate  :load_not_already_in_oven

  # Instance methods.

  # Ensures load being added not already in oven.
  def load_not_already_in_oven
    change = self.load_id_change_to_be_saved
    load_id = change[0].nil? ? change[1] : change[0]
    errors.add(:load_id, "can't be modified because it's already in the oven") unless Baking::Load.find(load_id).in_oven_at.blank?
  end

  # Don't allow order creation once cycle starts baking.
  def require_cycle_not_baking
    errors.add(:base, "Bake cycle already started, can't modify loadings") if self.cycle.has_started_baking?
  end

end