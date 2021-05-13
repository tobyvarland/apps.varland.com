class Permission < ApplicationRecord

  # Associations.
  belongs_to  :user

  # Scopes.
  scope :by_employee, -> { joins(:user).order("`users`.`employee_number`") }
  scope :for_active_employees, -> { joins(:user).where("`users`.`is_active` IS TRUE") }

end