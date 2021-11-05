class CreateEmployeeNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :employee_notes do |t|
      t.references :user,       null: false, foreign_key: true
      t.date :note_on,          null: false
      t.text :notes,            null: false
      t.datetime :discarded_at,  null: true, default: nil, index: true
      t.timestamps
    end
  end
end
