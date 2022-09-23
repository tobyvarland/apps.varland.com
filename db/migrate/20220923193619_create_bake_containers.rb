class CreateBakeContainers < ActiveRecord::Migration[6.1]
  def change
    create_table :bake_containers do |t|
      t.references  :stand,   null: false,  foreign_key: { to_table: :bake_stands }
      t.integer     :number,  null: false
      t.timestamps
      t.index [ :stand_id, :number ], name: "unique_number_on_stand", unique: true
    end
  end
end