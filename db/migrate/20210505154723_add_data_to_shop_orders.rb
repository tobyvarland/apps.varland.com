class AddDataToShopOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :as400_shop_orders,  :container_count, :integer,   null: false
    add_column :as400_shop_orders,  :container_type,  :string,    null: false
    add_column :as400_shop_orders,  :equipment_used,  :string,    null: true,   default: nil
    add_column :as400_shop_orders,  :received_at,     :datetime,  null: true,   default: nil
  end
end