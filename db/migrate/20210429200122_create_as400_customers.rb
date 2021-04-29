class CreateAs400Customers < ActiveRecord::Migration[6.1]
  def change
    create_table :as400_customers do |t|
      t.string      :code,  null: false,  limit: 6
      t.string      :name,  null: false
      t.timestamps
    end
    add_index :as400_customers, :code, unique: true
  end
end