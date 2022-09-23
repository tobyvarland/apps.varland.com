class Bake::LargeOvenCycle < Bake::Cycle

  # Associations.
  has_one :stand,
          inverse_of: 'cycle',
          foreign_key: 'cycle_id'

  # Callbacks.
  after_create_commit :create_stand

  # Instance methods.

  # Creates bake stand.
  def create_stand
    Bake::LargeStand.create(cycle: self)
  end

end