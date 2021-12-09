class Projects::Assignment < ApplicationRecord

  # Associations.
  belongs_to  :user,
              class_name: "::User",
              foreign_key: "user_id"
  belongs_to  :item,
              class_name: "Projects::Item",
              foreign_key: "item_id",
              inverse_of: :assignments

end