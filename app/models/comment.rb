class Comment < ApplicationRecord

  # Concerns.
  include Attachable

  # Associations.
  belongs_to  :user
  belongs_to  :commentable,
              polymorphic: true

  # Validations.
  validates :body,
            presence: true

  # Nested attributes.
  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true

  # Instance methods.

  # Returns comment date.
  def comment_date
    return self.comment_at unless self.comment_at.blank?
    return self.created_at
  end

end