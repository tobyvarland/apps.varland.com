class Scan::Document < ApplicationRecord

  # Uploads.
  has_one_attached  :scanned_file

  # Validations.
  validates :scanned_file,
            presence: true,
            blob: { content_type: ['application/pdf'] }

end