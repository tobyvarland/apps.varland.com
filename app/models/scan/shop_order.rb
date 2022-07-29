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

end