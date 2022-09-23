class CreateBakeStands < ActiveRecord::Migration[6.1]
  def change
    create_table :bake_stands do |t|
      t.references  :cycle, null: false,  foreign_key: { to_table: :bake_cycles }
      t.string      :type,  null: false
      t.string      :name,  null: true,   default: nil
      t.timestamps
    end
  end
end