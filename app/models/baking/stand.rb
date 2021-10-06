class Baking::Stand < ApplicationRecord

  # Enumerations.
  enum stand_type: {
    large: "large",
    small: "small",
    rods: "rods",
    iao: "iao"
  }, _default: "large"

  # Associations.
  has_many    :cycles,
              class_name: "Baking::Cycle",
              inverse_of: :stand
              dependent: :restrict_with_error

end