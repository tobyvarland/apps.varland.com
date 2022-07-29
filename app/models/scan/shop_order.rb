class Scan::ShopOrder < ApplicationRecord

  # Uploads.
  has_one_attached  :scanned_file

  # Concerns.
  include ShopOrderAssignable

  # Associations.
  belongs_to  :shop_order,
              class_name: 'AS400::ShopOrder'

  # Validations.
  validates :scanned_file,
            presence: true,
            blob: { content_type: ['application/pdf'] }

  # Callbacks.
  after_create_commit { Scan::ShopOrderBroadcastJob.perform_now self }

  # Scopes.
  include TextSearchable
  scope :today, -> { where('DATE(scan_shop_orders.created_at) = ?', Date.current) }
  scope :on_or_after, ->(value) { where("DATE(scan_shop_orders.created_at) >= ?", value) unless value.blank? }
  scope :on_or_before,  ->(value) { where("DATE(scan_shop_orders.created_at) <= ?", value) unless value.blank? }
  scope :with_search_term, ->(value) {
    return if value.blank?
    with_text_containing(:contents, value)
  }

end