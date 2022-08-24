class Training::Video < ApplicationRecord

  # Use FriendlyID.
  extend FriendlyId
  friendly_id :title, use: :slugged

  # Validations.
  validates :title, :description, :url,
            presence: true

  # Scopes.
  include TextSearchable
  scope :with_search_term, ->(value) {
    return if value.blank?
    with_text_containing(:description, value)
    title_ids = Training::Video.with_text_containing(:title, value).pluck(:id)
    description_ids = Training::Video.with_text_containing(:description, value).pluck(:id)
    where(id: [title_ids + description_ids].uniq)
  }

end