class CreateBakingProcedures < ActiveRecord::Migration[6.1]
  def change
    create_table :baking_procedures do |t|
      t.string      :description,   null: false
      t.integer     :minimum,       null: false
      t.integer     :maximum,       null: false
      t.integer     :setpoint,      null: false
      t.integer     :soak_length,   null: false
      t.string      :profile_name,  null: true,   default: nil
      t.timestamps
    end
  end
end