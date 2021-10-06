class Baking::Cycle < ApplicationRecord

  # Enumerations.
  enum container_type: {
    trays: "trays",
    rods: "rods"
  }, _default: "trays"

  # Associations.
  belongs_to  :oven_type,
              class_name: "Baking::OvenType"
  belongs_to  :oven,
              class_name: "Baking::Oven",
              optional: true
  belongs_to  :stand,
              class_name: "Baking::Stand"
  belongs_to  :user,
              class_name: "::User",
              optional: true
  belongs_to  :procedure,
              class_name: "Baking::Procedure",
              optional: true
  has_many    :orders,
              class_name: "Baking::Order",
              inverse_of: :cycle,
              dependent: :destroy
  has_many    :status_readings,
              class_name: "Baking::StatusReading",
              inverse_of: :cycle,
              dependent: :nullify
  has_many    :containers,
              class_name: "Baking::Container",
              inverse_of: :cycle,
              dependent: :destroy

  # Callbacks.
  after_create  :create_containers
  after_save    :get_pre_cycle_statuses

  # Instance methods.

  # Associates status readings with cycle from a few minutes before cycle begins.
  def get_pre_cycle_statuses
    if saved_change_to_attribute?(:cycle_started_at)
      self.oven.status_readings.where(cycle_id: nil).where("status_at >= ?", self.cycle_started_at.advance(minutes: -10)).update_all(cycle_id: self.id)
    end
  end

  # Creates containers. Run as after_create callback.
  def create_containers
    total_count = self.stand.row_count * self.stand.column_count * self.stand.containers_per_cell
    containers = []
    (1..total_count).each do |p|
      containers << { position: p }
    end
    self.containers.create(containers)
  end

end