class CreateBakingOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :baking_orders do |t|
      t.references  :cycle,               null: false,                  index: true,    foreign_key: { to_table: :baking_cycles }
      t.references  :process_code,        null: true,   default: nil,   index: true,    foreign_key: { to_table: :baking_process_codes }
      t.integer     :number,              null: false
      t.string      :customer,            null: false
      t.string      :process,             null: false
      t.string      :part,                null: false
      t.string      :sub,                 null: true,   default: nil
      t.string      :operation_letter,    null: true,   default: nil
      t.integer     :minimum,             null: true,   default: nil
      t.integer     :maximum,             null: true,   default: nil
      t.integer     :setpoint,            null: true,   default: nil
      t.integer     :soak_length,         null: true,   default: nil
      t.string      :profile_name,        null: true,   default: nil
      t.timestamps
    end
  end
end