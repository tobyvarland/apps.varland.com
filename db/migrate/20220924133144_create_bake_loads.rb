class CreateBakeLoads < ActiveRecord::Migration[6.1]
  def change
    create_table :bake_loads do |t|
      t.references  :shop_order,        null: false,  foreign_key: { to_table: :bake_shop_orders }
      t.integer     :number,            null: false
      t.boolean     :not_loaded,        null: false,  default: false
      t.datetime    :started_baking_at, null: true,   default: nil
      t.timestamps
      t.index [ :shop_order_id, :number ], name: "unique_load_on_order", unique: true
    end
  end
end