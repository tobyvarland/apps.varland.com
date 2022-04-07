class CreateGroovBakeCycles < ActiveRecord::Migration[6.1]
  def change
    create_table :groov_bake_cycles do |t|
      t.integer     :oven_type,           null: false
      t.references  :user,                null: true,   foreign_key: { to_table: :users }
      t.string      :oven,                null: true,   default: nil
      t.string      :side,                null: true,   default: nil
      t.datetime    :cycle_started_at,    null: true,   default: nil
      t.datetime    :loading_finished_at, null: true,   default: nil
      t.datetime    :purge_ended_at,      null: true,   default: nil
      t.datetime    :soak_started_at,     null: true,   default: nil
      t.datetime    :soak_ended_at,       null: true,   default: nil
      t.datetime    :gas_off_at,          null: true,   default: nil
      t.datetime    :cycle_ended_at,      null: true,   default: nil
      t.string      :bake_profile,        null: true,   default: nil
      t.integer     :setpoint,            null: true,   default: nil
      t.integer     :minimum,             null: true,   default: nil
      t.integer     :maximum,             null: true,   default: nil
      t.integer     :soak_length,         null: true,   default: nil
      t.integer     :bakestand_number,    null: true,   default: nil
      t.integer     :rod_cart_number,     null: true,   default: nil
      t.timestamps
      t.datetime    :discarded_at,        null: true,   default: nil
    end
  end
end