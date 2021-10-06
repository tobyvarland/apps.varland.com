class Baking::Order < ApplicationRecord

  # Associations.
  belongs_to  :cycle,
              class_name: "Baking::Cycle"
  belongs_to  :process_code,
              class_name: "Baking::ProcessCode",
              optional: true
  has_many    :loads,
              class_name: "Baking::Load",
              inverse_of: :order,
              dependent: :destroy

end