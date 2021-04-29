class Attachment < ApplicationRecord

  # Allow uploads.
  has_one_attached  :file

  # Associations.
  belongs_to  :attachable,
              polymorphic: true

  # Validations.
  validates :file,
            presence: true

end