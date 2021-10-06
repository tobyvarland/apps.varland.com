class CreateBakingStands < ActiveRecord::Migration[6.1]
  def change
    create_table :baking_stands do |t|
      t.integer     :number,      null: false
      t.string      :stand_type,  null: false
      t.timestamps
    end
  end
end