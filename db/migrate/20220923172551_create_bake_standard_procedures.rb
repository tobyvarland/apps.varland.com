class CreateBakeStandardProcedures < ActiveRecord::Migration[6.1]
  def change
    create_table :bake_standard_procedures do |t|
      t.string      :name,          null: false
      t.string      :process_codes, null: true,   default: nil
      t.integer     :setpoint,      null: false
      t.integer     :minimum,       null: false
      t.integer     :maximum,       null: false
      t.float       :soak_hours,    null: false
      t.float       :within_hours,  null: true,   default: nil
      t.string      :profile_name,  null: true,   default: nil
      t.timestamps
      t.index [ :name ], unique: true
    end
  end
end