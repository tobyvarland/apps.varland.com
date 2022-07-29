class AddSlugToScanShopOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :scan_shop_orders, :slug, :string
    add_index :scan_shop_orders, :slug, unique: true
  end
end