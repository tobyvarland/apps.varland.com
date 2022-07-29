class CreateScanShopOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :scan_shop_orders do |t|
      t.references  :shop_order,  null: false,  foreign_key: { to_table: :as400_shop_orders }
      t.text        :contents,    null: false
      t.timestamps
    end
  end
end