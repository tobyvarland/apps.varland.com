class Bake::LargeStand < Bake::Stand

  # Class constants.
  COLUMN_COUNT = 4
  ROW_COUNT = 11

  # Instance methods.

  # Creates containers for bake stand.
  def create_containers
    Bake::Container.insert_all((1..(Bake::LargeStand::COLUMN_COUNT * Bake::LargeStand::ROW_COUNT)).map {|container_number|
      { stand_id: self.id,
        number: container_number,
        created_at: Time.current,
        updated_at: Time.current  }})
  end

end