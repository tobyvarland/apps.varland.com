class Comment < ApplicationRecord

  # Soft deletes.
  include Discard::Model
  default_scope -> { kept }

  # Associations.
  include Attachable
  belongs_to  :user
  belongs_to  :commentable,
              polymorphic: true,
              touch: true

  # Validations.
  validates :body, :comment_at,
            presence: true

  # Nested attributes.
  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true

  # Scopes.
  scope :chronological, -> { order(:comment_at) }

  # Callbacks.
  before_validation :set_date

  # Instance methods.

  # Sets comment date.
  def set_date
    return unless self.comment_at.blank?
    self.comment_at = DateTime.current
  end

end