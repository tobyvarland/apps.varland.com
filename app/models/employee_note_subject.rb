class EmployeeNoteSubject < ApplicationRecord

  # Associations
  belongs_to  :user, 
              class_name: "::User"
  belongs_to  :employee_note,
              class_name: "::EmployeeNote"

  # Validations
  validates   :note_type, 
              presence: true, 
              inclusion: { in: ["Positive", "Negative", "Neutral"] }

end
