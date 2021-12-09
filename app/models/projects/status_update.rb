class Projects::StatusUpdate < ApplicationRecord

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
  belongs_to  :user,
              class_name: "::User",
              foreign_key: "user_id"
  belongs_to  :item,
              class_name: "Projects::Item",
              foreign_key: "item_id",
              inverse_of: :status_updates

  # Validations.
  validates   :status,
              presence: true,
              inclusion: { in: ["requested", "opened", "close_requested", "closed", "deleted", "reopened", "held"] }

end