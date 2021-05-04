class Quality::RejectTagLoad < ApplicationRecord

  # Associations.
  belongs_to  :reject_tag,
              class_name: "Quality::RejectTag"

  # Validations.
  validates :number,
            presence: true

end