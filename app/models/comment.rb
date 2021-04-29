class Comment < ApplicationRecord

  # Concerns.
  include Attachable

  # Associations.
  belongs_to  :user
  belongs_to  :commentable,
              polymorphic: true

end