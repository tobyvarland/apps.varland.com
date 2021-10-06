class Baking::ProcessCode < ApplicationRecord

  # Associations.
  has_many    :type_assignments,
              class_name: "Baking::TypeAssignment",
              inverse_of: :process_code
              dependent: :destroy
  has_many    :orders,
              class_name: "Baking::Order",
              inverse_of: :process_code
              dependent: :nullify

end