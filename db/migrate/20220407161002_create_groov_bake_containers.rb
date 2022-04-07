class CreateGroovBakeContainers < ActiveRecord::Migration[6.1]
  def change
    create_table :groov_bake_containers do |t|
      t.references  :load,                      null: false,  foreign_key: { to_table: :groov_bake_loads }
      t.string      :description,               null: false
      t.integer     :bakestand_column,          null: true,   default: nil
      t.integer     :bakestand_row,             null: true,   default: nil
      t.integer     :rod_cart_shelf,            null: true,   default: nil
      t.integer     :rod_cart_position,         null: true,   default: nil
      t.integer     :oven_shelf,                null: true,   default: nil
      t.integer     :oven_shelf_tray_position,  null: true,   default: nil
      t.integer     :oven_shelf_rod_position,   null: true,   default: nil
      t.timestamps
    end
  end
end