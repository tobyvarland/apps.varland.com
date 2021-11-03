class EmployeeNoteSubject < ApplicationRecord
  belongs_to :user
  belongs_to :employee_note
end
