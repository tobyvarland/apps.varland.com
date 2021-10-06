class Baking::Container < ApplicationRecord

  # Associations.
  belongs_to  :load,
              class_name: "Baking::Load",
              optional: true
  belongs_to  :cycle,
              class_name: "Baking::Cycle"

end