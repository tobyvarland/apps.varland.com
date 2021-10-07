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
              inverse_of: :stand,
              dependent: :restrict_with_error
  has_many    :stand_assignments,
              class_name: "Baking::StandAssignment",
              inverse_of: :stand,
              dependent: :destroy

  # Instance methods.

  # Define total number of rows on bakestand.
  def row_count
    case self.stand_type
    when "large", :large, "iao", :iao
      return 10
    when "small", :small
      return 8
    when "rods", :rods
      return 9
    end
  end

  # Define total number of columns on bakestand.
  def column_count
    case self.stand_type
    when "large", :large, "iao", :iao
      return 4
    when "small", :small
      return 2
    when "rods", :rods
      return 1
    end
  end

  # Define number of trays/rods per cell.
  def containers_per_cell
    case self.stand_type
    when "large", :large, "iao", :iao, "small", :small
      return 1
    when "rods", :rods
      return 15
    end
  end

end