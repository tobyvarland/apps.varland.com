class Baking::StandAssignment < ApplicationRecord

  # Associations.
  belongs_to  :oven_type,
              class_name: "Baking::OvenType"
  belongs_to  :stand,
              class_name: "Baking::Stand"

end