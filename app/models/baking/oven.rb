class Baking::Oven < ApplicationRecord

  # Associations.
  belongs_to  :oven_type,
              class_name: "Baking::OvenType"
  has_many    :cycles,
              class_name: "Baking::Cycle",
              inverse_of: :oven
              dependent: :restrict_with_error
  has_many    :status_readings,
              class_name: "Baking::StatusReading",
              inverse_of: :oven
              dependent: :restrict_with_error

end