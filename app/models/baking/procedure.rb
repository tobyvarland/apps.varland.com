class Baking::Procedure < ApplicationRecord

  # Associations.
  has_many    :cycles,
              class_name: "Baking::Cycle",
              inverse_of: :procedure
              dependent: :restrict_with_error

end