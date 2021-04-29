class Review < ApplicationRecord

  # Associations.
  belongs_to  :user
  belongs_to  :reviewable,
              polymorphic: true

end