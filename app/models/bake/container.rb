class Bake::Container < ApplicationRecord

  # Associations.
  belongs_to  :stand
  has_many  :loadings,
            inverse_of: 'container',
            foreign_key: 'container_id'
  has_many  :loads,
            through: :loadings

  # Validations.
  validates :number,
            presence: true,
            numericality: { only_integer: true, greater_than: 0 },
            uniqueness: { scope: :stand_id }

  # Instance methods.

  # Returns container column.
  def column
    return ((self.number - 1) / self.stand.class::ROW_COUNT).to_i + 1
  end

  # Returns container row.
  def row
    return self.number % self.stand.class::ROW_COUNT == 0 ? self.stand.class::ROW_COUNT : self.number % self.stand.class::ROW_COUNT
  end

end