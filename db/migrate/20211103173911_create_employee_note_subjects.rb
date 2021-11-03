class CreateEmployeeNoteSubjects < ActiveRecord::Migration[6.1]
  def change
    create_table :employee_note_subjects do |t|
      t.references :user, null: false, foreign_key: true
      t.references :employee_note, null: false, foreign_key: true
      t.string :note_type

      t.timestamps
    end
  end
end
