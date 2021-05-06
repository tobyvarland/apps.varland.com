class AddScheduleCodeToShopOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :as400_shop_orders, :schedule_code, :string, null: false
  end
end