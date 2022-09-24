class CreateBakeLoadings < ActiveRecord::Migration[6.1]
  def change
    create_table :bake_loadings do |t|
      t.references  :container, null: false,  foreign_key: { to_table: :bake_containers }
      t.references  :load,      null: false,  foreign_key: { to_table: :bake_loads }
      t.timestamps
    end
  end
end