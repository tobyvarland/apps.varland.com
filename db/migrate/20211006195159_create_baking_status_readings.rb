class CreateBakingStatusReadings < ActiveRecord::Migration[6.1]
  def change
    create_table :baking_status_readings do |t|
      t.references  :oven,                null: false,                  index: true,    foreign_key: { to_table: :baking_ovens }
      t.references  :cycle,               null: true,   default: nil,   index: true,    foreign_key: { to_table: :baking_cycles }
      t.datetime    :status_at,           null: false
      t.float       :air_temperature,     null: false
      t.float       :parts_temperature,   null: false
      t.float       :chamber_pressure,    null: true,   default: nil
      t.boolean     :is_purging,          null: true,   default: nil
      t.boolean     :is_cooling,          null: true,   default: nil
      t.boolean     :is_gas_flowing,      null: true,   default: nil
      t.timestamps
    end
  end
end