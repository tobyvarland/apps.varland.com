class CreateBakingContainers < ActiveRecord::Migration[6.1]
  def change
    create_table :baking_containers do |t|
      t.references  :cycle,               null: false,                  index: true,    foreign_key: { to_table: :baking_cycles }
      t.references  :load,                null: true,   default: nil,   index: true,    foreign_key: { to_table: :baking_loads }
      t.integer     :position,            null: false
      t.timestamps
    end
  end
end