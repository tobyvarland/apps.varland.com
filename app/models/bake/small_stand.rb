class Bake::SmallStand < Bake::Stand

  # Class constants.
  COLUMN_COUNT = 2
  ROW_COUNT = 8

  # Creates containers for bake stand.
  def create_containers
    Bake::Container.insert_all((1..(Bake::SmallStand::COLUMN_COUNT * Bake::SmallStand::ROW_COUNT)).map {|container_number|
      { stand_id: self.id,
        number: container_number,
        created_at: Time.current,
        updated_at: Time.current  }})
  end

end