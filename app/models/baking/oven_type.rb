class Baking::OvenType < ApplicationRecord

  # Associations.
  has_many    :ovens,
              class_name: "Baking::Oven",
              inverse_of: :oven_type,
              dependent: :restrict_with_error
  has_many    :cycles,
              class_name: "Baking::Cycle",
              inverse_of: :oven_type,
              dependent: :restrict_with_error
  has_many    :type_assignments,
              class_name: "Baking::TypeAssignment",
              inverse_of: :oven_type,
              dependent: :destroy

end