class AddPieceWeightToShopOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :as400_shop_orders,  :piece_weight,  :float, null: false
  end
end