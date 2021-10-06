class CreateBakingCycles < ActiveRecord::Migration[6.1]
  def change
    create_table :baking_cycles do |t|
      t.references  :oven_type,           null: false,                  index: true,    foreign_key: { to_table: :baking_oven_types }
      t.references  :oven,                null: true,   default: nil,   index: true,    foreign_key: { to_table: :baking_ovens }
      t.references  :stand,               null: false,                  index: true,    foreign_key: { to_table: :baking_stands }
      t.references  :user,                null: true,   default: nil,   index: true,    foreign_key: { to_table: :users }
      t.string      :container_type,      null: false
      t.datetime    :cycle_started_at,    null: true,   default: nil
      t.datetime    :purge_ended_at,      null: true,   default: nil
      t.datetime    :soak_started_at,     null: true,   default: nil
      t.datetime    :soak_ended_at,       null: true,   default: nil
      t.datetime    :gas_off_at,          null: true,   default: nil
      t.datetime    :finished_at,         null: true,   default: nil
      t.timestamps
    end
  end
end