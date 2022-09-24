class Bake::Loading < ApplicationRecord

  # Associations.
  belongs_to  :container
  belongs_to  :load

end