class Baking::Stand < ApplicationRecord

  # Enumerations.
  enum stand_type: {
    large: "large",
    small: "small",
    rods: "rods",
    iao: "iao"
  }, _default: "large"

end