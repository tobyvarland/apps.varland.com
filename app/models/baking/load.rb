class Baking::Load < ApplicationRecord

  # Associations.
  belongs_to  :order,
              class_name: "Baking::Order"
  has_many    :containers,
              class_name: "Baking::Container",
              inverse_of: :load,
              dependent: :nullify

end