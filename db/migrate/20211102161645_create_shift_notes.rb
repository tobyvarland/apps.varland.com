class CreateShiftNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :shift_notes do |t|
      t.references    :user,                null: false,                  foreign_key: true
      t.date          :note_on,             null: false
      t.integer       :shift,               null: false
      t.integer       :department,          null: true,   default: nil
      t.text          :notes,               null: false
      t.boolean       :is_for_it,           null: false,  default: false
      t.boolean       :is_for_lab,          null: false,  default: false
      t.boolean       :is_for_maintenance,  null: false,  default: false
      t.boolean       :is_for_plating,      null: false,  default: false
      t.boolean       :is_for_qc,           null: false,  default: false
      t.boolean       :is_for_shipping,     null: false,  default: false
      t.datetime      :discarded_at,        null: true,   default: nil,   index: true
      t.timestamps
    end
  end
end