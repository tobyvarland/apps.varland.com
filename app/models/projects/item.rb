class Projects::Item < ApplicationRecord

  # Enumerations.
  enum status: {
    requested: "requested",
    opened: "opened",
    close_requested: "close_requested",
    closed: "closed",
    reopened: "reopened",
    deleted: "deleted",
    held: "held"
  }

  # Associations.
  include Commentable
  belongs_to  :category,
              class_name: "Projects::Category",
              foreign_key: "category_id",
              inverse_of: :items
  has_many    :status_updates,
              class_name: "Projects::StatusUpdate",
              foreign_key: "item_id",
              inverse_of: :item,
              dependent: :destroy
  has_many    :assignments,
              class_name: "Projects::Assignment",
              foreign_key: "item_id",
              inverse_of: :item,
              dependent: :destroy

  # Nested attributes.
  accepts_nested_attributes_for :comments, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :assignments, reject_if: :all_blank, allow_destroy: true

  # Validations.
  validates   :status,
              presence: true,
              inclusion: { in: ["requested", "opened", "close_requested", "closed", "deleted", "reopened", "held"] }
  validates   :percent_complete,
              numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100 },
              allow_blank: true
  validates   :projected_hours,
              numericality: { greater_than: 0 },
              allow_blank: true
  validate    :require_valid_priority

  # Callbacks.
  before_validation   :initialize_status_on_create,
                      on: :create
  after_create_commit :set_item_number
  after_commit        :log_status_update

  # Instance Methods.

  # Returns date when item closed.
  def closed_on
    return nil if self.status != "closed"
    return self.status_updates.closed.order(:created_at).last.created_at.to_date
  end

  # Returns user who closed item.
  def closed_by
    return nil if self.status != "closed"
    return self.status_updates.closed.order(:created_at).last.user
  end

  # Returns date when item opened.
  def opened_on
    return nil if self.status_updates.opened.length == 0
    return self.status_updates.opened.order(:created_at).first.created_at.to_date
  end

  # Returns user who opened item.
  def opened_by
    return nil if self.status_updates.opened.length == 0
    return self.status_updates.opened.order(:created_at).first.user
  end

  # Logs status update after commit.
  def log_status_update
    if self.status_updates.length == 0 || self.status_updates.last.status != self.status
      self.status_updates.create(user: User.current_user, status: self.status)
    end
  end

  # Initialize status on create.
  def initialize_status_on_create
    if self.status.blank?
      self.status = "opened"
    end
  end

  # Sets item number to next available for category.
  def set_item_number
    number = self.category.last_number_used + 1
    self.category.update_column :last_number_used, number
    self.update_column :number, number
  end

  # Validates priority against category.
  def require_valid_priority
    if self.category.present? || self.category.use_priorities
      self.errors.add(:priority, "is invalid") unless [1, 2, 3].include?(self.priority)
    end
  end

end