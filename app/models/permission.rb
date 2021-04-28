class Permission < ApplicationRecord

  # Associations.
  belongs_to  :user

  # Scopes.
  scope :by_employee, -> { joins(:user).order("`users`.`employee_number`") }

end