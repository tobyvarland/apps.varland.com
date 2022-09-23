class Bake::GrieveCycle < Bake::Cycle

  # Associations.
  has_many  :stands,
            inverse_of: 'cycle',
            foreign_key: 'cycle_id'

end