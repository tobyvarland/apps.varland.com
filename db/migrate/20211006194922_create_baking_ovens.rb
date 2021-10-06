class CreateBakingOvens < ActiveRecord::Migration[6.1]
  def change
    create_table :baking_ovens do |t|
      t.references  :oven_type,     null: false,  index: true,    foreign_key: { to_table: :baking_oven_types }
      t.string      :description,   null: false
      t.boolean     :is_left_side,  null: false,  default: false
      t.timestamps
    end
  end
end