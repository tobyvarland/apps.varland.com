class Baking::StatusReading < ApplicationRecord

  # Associations.
  belongs_to  :oven,
              class_name: "Baking::Oven"
  belongs_to  :cycle,
              class_name: "Baking::Cycle",
              optional: true

end