class Bake::RodCart < Bake::Stand

  # Class constants.
  COLUMN_COUNT = 6
  ROW_COUNT = 8

  # Creates containers for bake stand.
  def create_containers
    Bake::Container.insert_all((1..(Bake::RodCart::COLUMN_COUNT * Bake::RodCart::ROW_COUNT)).map {|container_number|
      { stand_id: self.id,
        number: container_number,
        created_at: Time.current,
        updated_at: Time.current  }})
  end

end