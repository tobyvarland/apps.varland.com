class Baking::Cycle < ApplicationRecord

  # Enumerations.
  enum container_type: {
    trays: "trays",
    rods: "rods"
  }

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
  has_many    :loads,
              through: :orders

  # Scopes.
  scope :not_finished, -> { where(finished_at: nil) }
  
  # Validations.
  validates :container_type,
            presence: true
  validate :bakestand_allowed_in_oven_type, on: :create
  validate :check_standard_procedure_type, on: :create
  validate :ensure_stand_available, on: :create

  # Callbacks.
  before_validation :set_container_type_from_stand,
                    on: :create
  after_create      :create_containers
  after_save        :get_pre_cycle_statuses

  # Instance methods.

  # Sets container type for cycle based on bakestand.
  def set_container_type_from_stand
    return if self.stand_id.blank?
    if self.stand.stand_type == "rods" || self.stand.stand_type == :rods
      self.container_type = :rods
    else
      self.container_type = :trays
    end
  end

  # Ensures stand not currently in use.
  def ensure_stand_available
    return if self.stand.blank?
    if Baking::Cycle.not_finished.pluck(:stand_id).include?(self.stand_id)
      errors.add(:stand_id, "is currently in use")
    end
  end

  # Ensures standard procedure valid for selected oven type.
  def check_standard_procedure_type
    return if self.oven_type.blank? || self.procedure.blank?
    if self.oven_type.is_iao != self.procedure.is_for_iao?
      errors.add(:procedure_id, "is not valid for the selected oven type")
    end
  end

  # Ensures bakestand allowed in selected oven type.
  def bakestand_allowed_in_oven_type
    return if self.oven_type.blank? || self.stand.blank?
    unless self.stand.stand_assignments.pluck(:oven_type_id).include?(self.oven_type_id)
      errors.add(:stand_id, "is not allowed in the selected oven type")
    end
  end

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
    return !self.finished_loading_at.blank?
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
      return "Loading" if self.finished_loading_at.blank?
      return "Warming Up" if self.soak_started_at.blank?
      return "Soaking" if self.soak_ended_at.blank?
    end
    return "Finished"
  end

  # Returns whether or not cycle is ready for baking.
  def ready_for_baking?
    return "Bake cycle has already started baking" if self.has_started_baking?
    return "No shop orders added to bake cycle" unless self.orders.count > 0
    return true if self.orders.count == 0 && !self.procedure_id.blank?
    self.orders.each do |order|
      next if order.new_record?
      return "SO ##{order.number} does not have any loads" unless order.loads.count > 0
      order.loads.each do |load|
        return "SO ##{order.number} Load ##{load.description} is not placed in the oven" unless load.containers.count > 0
      end
    end
    self.loads.each do |load|
      return true if load.is_on_bakestand
    end
    return "No loads marked physically on the bakestand"
  end

  # Returns baking minimum for cycle.
  def minimum
    return self.procedure.minimum unless self.procedure.blank?
    case self.orders.length
    when 0
      return nil
    when 1
      return self.orders.first.minimum
    else
      return self.orders.maximum(:minimum)
    end
  end

  # Returns baking maximum for cycle.
  def maximum
    return self.procedure.maximum unless self.procedure.blank?
    case self.orders.length
    when 0
      return nil
    when 1
      return self.orders.first.maximum
    else
      return self.orders.minimum(:maximum)
    end
  end

  # Returns baking setpoint for cycle.
  def setpoint
    return self.procedure.setpoint unless self.procedure.blank?
    case self.orders.length
    when 0
      return nil
    when 1
      return self.orders.first.setpoint
    else
      min = self.minimum
      max = self.maximum
      return min + ((max - min) / 2)
    end
  end

  # Returns baking soak length for cycle.
  def soak_length
    return self.procedure.soak_length unless self.procedure.blank?
    case self.orders.length
    when 0
      return nil
    when 1
      return self.orders.first.soak_length
    else
      return self.orders.maximum(:soak_length)
    end
  end

  # Returns baking soak length for cycle.
  def profile_name
    return self.procedure.profile_name unless self.procedure.blank?
    return nil if self.orders.length == 0
    return self.orders.first.profile_name
  end

end