class CreateBakingStandAssignments < ActiveRecord::Migration[6.1]
  def change
    create_table :baking_stand_assignments do |t|
      t.references  :oven_type,           null: false,  index: true,    foreign_key: { to_table: :baking_oven_types }
      t.references  :stand,               null: false,  index: true,    foreign_key: { to_table: :baking_stands }
      t.timestamps
    end
  end
end