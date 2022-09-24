class Bake::Stand < ApplicationRecord

  # Associations.
  belongs_to  :cycle
  has_many  :containers,
            inverse_of: 'stand',
            foreign_key: 'stand_id'

  # Callbacks.
  after_create_commit :create_containers

end