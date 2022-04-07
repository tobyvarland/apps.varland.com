class CreateGroovBakeShopOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :groov_bake_shop_orders do |t|
      t.references  :cycle,             null: false,  foreign_key: { to_table: :groov_bake_cycles }
      t.references  :as400_shop_order,  null: false,  foreign_key: { to_table: :as400_shop_orders }
      t.integer     :container_type,    null: false
      t.string      :operation_letter,  null: false
      t.string      :bake_profile,      null: true,   default: nil
      t.integer     :setpoint,          null: false
      t.integer     :minimum,           null: false
      t.integer     :maximum,           null: false
      t.integer     :soak_length,       null: false
      t.integer     :bake_within,       null: false
      t.timestamps
    end
  end
end