class AddBakeParamsToShopOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :as400_shop_orders, :iao_profile,      :string,  null: true, default: nil
    add_column :as400_shop_orders, :iao_setpoint,     :integer, null: true, default: nil
    add_column :as400_shop_orders, :iao_minimum,      :integer, null: true, default: nil
    add_column :as400_shop_orders, :iao_maximum,      :integer, null: true, default: nil
    add_column :as400_shop_orders, :iao_soak_length,  :integer, null: true, default: nil
  end
end