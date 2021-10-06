class Baking::TypeAssignment < ApplicationRecord

  # Associations.
  belongs_to  :oven_type,
              class_name: "Baking::OvenType"
  belongs_to  :process_code,
              class_name: "Baking::ProcessCode"

end