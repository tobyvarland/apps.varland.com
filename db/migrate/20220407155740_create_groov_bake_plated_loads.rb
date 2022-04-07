class CreateGroovBakePlatedLoads < ActiveRecord::Migration[6.1]
  def change
    create_table :groov_bake_plated_loads do |t|
      t.references  :load,              null: true,   foreign_key: { to_table: :groov_bake_loads },   default: nil
      t.references  :as400_shop_order,  null: false,  foreign_key: { to_table: :as400_shop_orders }
      t.integer     :number,            null: false
      t.integer     :department,        null: false
      t.datetime    :out_of_plating_at, null: false
      t.integer     :bake_within,       null: false
      t.timestamps
    end
  end
end