class CreateAs400Parts < ActiveRecord::Migration[6.1]
  def change
    create_table :as400_parts do |t|
      t.references  :customer,          null: false
      t.string      :process,           null: false,  limit: 3
      t.string      :part,              null: false,  limit: 17
      t.string      :sub,               null: true,   limit: 1
      t.integer     :control_number,    null: false
      t.string      :name,              null: false
      t.string      :process_spec,      null: false
      t.string      :description,       null: false
      t.float       :square_feet,       null: false
      t.float       :piece_weight,      null: false
      t.float       :pounds_per_cubic,  null: false
      t.timestamps
    end
    add_foreign_key :as400_parts, :as400_customers, column: :customer_id
    add_index :as400_parts, [:customer_id, :process, :part, :sub], unique: true, name: "unique_part_spec"
  end
end