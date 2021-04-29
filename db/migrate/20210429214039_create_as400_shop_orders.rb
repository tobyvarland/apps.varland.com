class CreateAs400ShopOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :as400_shop_orders do |t|
      t.references  :part,            null: false
      t.integer     :number,          null: false
      t.string      :purchase_order,  null: true,   default: nil
      t.integer     :containers,      null: false
      t.string      :container_type,  null: false
      t.date        :received_on,     null: false
      t.date        :written_up_on,   null: false
      t.date        :promised_on,     null: true,   default: nil
      t.float       :pounds,          null: false
      t.integer     :pieces,          null: false
      t.string      :status,          null: true,   default: nil
      t.date        :inspected_on,    null: true,   default: nil
      t.string      :inspected_by,    null: true,   default: nil
      t.timestamps
    end
    add_foreign_key :as400_shop_orders, :as400_parts, column: :part_id
    add_index :as400_shop_orders, :number, unique: true, name: "unique_shop_order"
  end
end