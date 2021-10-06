class Baking::Cycle < ApplicationRecord

  # Associations.
  belongs_to  :oven_type,
              class_name: "Baking::OvenType"
  belongs_to  :oven,
              class_name: "Baking::Oven",
              optional: true
  belongs_to  :stand,
              class_name: "Baking::Stand"
  belongs_to  :user,
              class_name: "::User",
              optional: true
  belongs_to  :procedure,
              class_name: "Baking::Procedure",
              optional: true
  has_many    :orders,
              class_name: "Baking::Order",
              inverse_of: :cycle,
              dependent: :destroy
  has_many    :status_readings,
              class_name: "Baking::StatusReading",
              inverse_of: :cycle,
              dependent: :nullify
  has_many    :containers,
              class_name: "Baking::Container",
              inverse_of: :cycle,
              dependent: :destroy

  # Enumerations.
  enum container_type: {
    trays: "trays",
    rods: "rods"
  }, _default: "trays"

end