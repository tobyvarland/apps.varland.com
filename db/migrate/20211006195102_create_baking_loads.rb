class CreateBakingLoads < ActiveRecord::Migration[6.1]
  def change
    create_table :baking_loads do |t|
      t.references  :order,       null: false,                  index: true,    foreign_key: { to_table: :baking_orders }
      t.integer     :number,      null: false
      t.boolean     :is_rework,   null: false,  default: false
      t.timestamps
    end
  end
end
