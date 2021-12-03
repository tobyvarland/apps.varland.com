class Notification < ApplicationRecord

  # Associations.
  belongs_to  :user

  # Validations.
  validates :text,
            presence: true

  # Scopes.
  default_scope -> { order(created_at: :desc) }
  scope :unread,  -> { where(is_read: false) }

end