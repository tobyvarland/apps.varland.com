class Baking::Load < ApplicationRecord

  # Associations.
  belongs_to  :order,
              class_name: "Baking::Order"
  has_many    :containers,
              class_name: "Baking::Container",
              inverse_of: :load,
              dependent: :nullify

  # Scopes.
  scope :by_number, -> { order(:number, :is_rework) }

  # Instance methods.

  # Returns load description.
  def description
    return "#{self.number}#{self.is_rework ? "*" : ""}"
  end

end