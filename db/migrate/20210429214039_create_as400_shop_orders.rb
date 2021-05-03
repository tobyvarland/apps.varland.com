class CreateAs400ShopOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :as400_shop_orders do |t|
      t.string      :customer_code,     null: false,  limit: 6
      t.string      :process_code,      null: false,  limit: 3
      t.string      :part,              null: false,  limit: 17
      t.string      :sub,               null: true,   limit: 1
      t.integer     :number,            null: false
      t.string      :part_name,         null: false
      t.string      :process_spec,      null: false
      t.string      :part_description,  null: false
      t.string      :customer_name,     null: false
      t.string      :purchase_order,    null: true,   default: nil
      t.date        :received_on,       null: false
      t.date        :written_up_on,     null: false
      t.float       :pounds,            null: false
      t.integer     :pieces,            null: false
      t.timestamps
    end
    add_index :as400_shop_orders, :number, unique: true, name: "unique_shop_order"
  end
end