class CreateShippingTricoBins < ActiveRecord::Migration[6.1]
  def change
    create_table :shipping_trico_bins do |t|
      t.references  :shop_order,          null: false
      t.datetime    :load_at,             null: false
      t.integer     :load_number,         null: false
      t.float       :scale_weight,        null: false
      t.float       :percent_of_total,    null: true,   default: nil
      t.integer     :proportional_pieces, null: true,   default: nil
      t.integer     :fudge_pieces,        null: true,   default: nil
      t.timestamps
    end
    add_foreign_key :shipping_trico_bins, :as400_shop_orders, column: :shop_order_id
  end
end