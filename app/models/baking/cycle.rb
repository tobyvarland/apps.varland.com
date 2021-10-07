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

  # Return if cycle has finished baking.
  def has_finished_baking?
    return !self.finished_at.blank?
  end

  # Determine if cycle is able to be edited because not yet started.
  def has_started_baking?
    return !self.cycle_started_at.blank?
  end

  # Return description of current step.
  def step_description
    return "Queued" if self.cycle_started_at.blank?
    case self.oven_type.is_iao
    when true
      return "Purging" if self.purge_ended_at.blank?
      return "Warming Up" if self.soak_started_at.blank?
      return "Soaking" if self.soak_ended_at.blank?
      return "Cooling (w/ Gas)" if self.gas_off_at.blank?
      return "Cooling (w/o Gas)" if self.finished_at.blank?
    when false
      return "Warming Up" if self.soak_started_at.blank?
      return "Soaking" if self.soak_ended_at.blank?
    end
    return "Finished"
  end

  # Returns whether or not cycle is ready for baking.
  def ready_for_baking?
    return "Bake cycle has already started baking" if self.has_started_baking?
    return "No shop orders added to bake cycle" unless self.orders.count > 0
    self.orders.each do |order|
      next if order.new_record?
      return "SO ##{order.number} does not have any loads" unless order.loads.count > 0
      order.loads.each do |load|
        return "SO ##{order.number} Load ##{load.description} is not placed in the oven" unless load.containers.count > 0
      end
    end
    return true
  end

end