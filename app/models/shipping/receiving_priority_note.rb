class Shipping::ReceivingPriorityNote < ApplicationRecord

  # Associations.
  belongs_to  :requested_by_user,
              class_name: "::User"
  belongs_to  :completed_by_user,
              class_name: "::User",
              optional: true

  # Validations.
  validates :request_type, :request_details,
            presence: true
  validates :request_type,
            inclusion: { in: ["Customer Parts", "Chemicals", "Purchased Item", "Other"] }

  # Scopes.
  scope :incomplete, -> { where(completed_at: nil) }

  # Callbacks.
  before_update :set_completed_timestamp
  after_update  :process_notification

  # Instance methods.

  # Sends notification email.
  def process_notification
    Shipping::ReceivingPriorityNoteMailer.with(note: self).completion_email.deliver_later
  end

  # Sets completed timestamp before update if user present.
  def set_completed_timestamp
    return unless self.completed_by_user.present?
    return unless self.completed_at.nil?
    self.completed_at = DateTime.current
  end

  # Returns requesting user name.
  def requesting_user_name
    return nil unless self.requested_by_user.present?
    return self.requested_by_user.name
  end

  # Class methods.

  # Returns options for request type.
  def self.request_type_options
    return ["Customer Parts", "Chemicals", "Purchased Item", "Other"].sort
  end

end