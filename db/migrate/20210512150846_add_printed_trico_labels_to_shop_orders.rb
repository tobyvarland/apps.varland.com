class AddPrintedTricoLabelsToShopOrders < ActiveRecord::Migration[6.1]
  def change
    add_column  :as400_shop_orders, :printed_trico_labels,  :boolean, null: false,  default: false
  end
end
