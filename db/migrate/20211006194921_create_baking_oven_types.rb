class CreateBakingOvenTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :baking_oven_types do |t|
      t.string      :description,   null: false
      t.boolean     :is_iao,        null: false,  default: false
      t.integer     :max_trays,     null: false,  default: 0
      t.integer     :max_rods,      null: false,  default: 0
      t.timestamps
    end
  end
end