class Baking::StatusReading < ApplicationRecord

  # Associations.
  belongs_to  :oven,
              class_name: "Baking::Oven"
  belongs_to  :cycle,
              class_name: "Baking::Cycle",
              optional: true

  # Scopes.
  default_scope { order(:status_at) }

  # Callbacks.
  before_create :find_cycle

  # Instance methods.

  # Finds associated cycle.
  def find_cycle
    self.cycle = self.oven.cycles.where('cycle_started_at <= ?', self.status_at).where('finished_at >= ? or finished_at IS NULL', self.status_at.advance(minutes: -10)).first
  end

end