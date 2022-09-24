class Bake::Cycle < ApplicationRecord

  # Associations.
  belongs_to  :user,
              optional: true

end