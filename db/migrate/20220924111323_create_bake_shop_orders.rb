class CreateBakeShopOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :bake_shop_orders do |t|
      t.references  :cycle,         null: false,  foreign_key: { to_table: :bake_cycles }
      t.integer     :number,        null: false
      t.string      :customer,      null: false
      t.string      :process,       null: false
      t.string      :part,          null: false
      t.string      :sub,           null: true,   default: nil
      t.string      :operation,     null: false
      t.integer     :setpoint,      null: false
      t.integer     :minimum,       null: false
      t.integer     :maximum,       null: false
      t.float       :soak_hours,    null: false
      t.float       :within_hours,  null: true,   default: nil
      t.string      :profile_name,  null: true,   default: nil
      t.timestamps
      t.index [ :cycle_id, :number ], name: "unique_order_on_cycle", unique: true
    end
  end
end