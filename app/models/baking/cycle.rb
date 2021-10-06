class Baking::Cycle < ApplicationRecord

  # Enumerations.
  enum container_type: {
    trays: "trays",
    rods: "rods"
  }, _default: "trays"

end