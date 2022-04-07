class CreateGroovBakeLoads < ActiveRecord::Migration[6.1]
  def change
    create_table :groov_bake_loads do |t|
      t.references  :shop_order,      null: false,  foreign_key: { to_table: :groov_bake_shop_orders }
      t.integer     :number,          null: false
      t.boolean     :is_rework,       null: false,  default: false
      t.boolean     :is_on_bakestand, null: false,  default: true
      t.datetime    :in_oven_at,      null: true,   default: nil
      t.integer     :container_count, null: false
      t.timestamps
    end
  end
end