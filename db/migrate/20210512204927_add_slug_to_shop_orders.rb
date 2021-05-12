class AddSlugToShopOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :as400_shop_orders, :slug, :string
    add_index :as400_shop_orders, :slug, unique: true
  end
end