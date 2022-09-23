class Bake::RodCart < Bake::Stand

  # Creates containers for bake stand.
  def create_containers
    Bake::Container.insert_all((1..48).map {|container_number| {  stand_id: self.id,
                                                                  number: container_number,
                                                                  created_at: Time.current,
                                                                  updated_at: Time.current  }})
  end

end