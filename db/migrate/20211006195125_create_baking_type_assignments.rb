class CreateBakingTypeAssignments < ActiveRecord::Migration[6.1]
  def change
    create_table :baking_type_assignments do |t|
      t.references  :oven_type,           null: false,  index: true,    foreign_key: { to_table: :baking_oven_types }
      t.references  :process_code,        null: false,  index: true,    foreign_key: { to_table: :baking_process_codes }
      t.integer     :max_temperature,     null: false
      t.timestamps
    end
  end
end
