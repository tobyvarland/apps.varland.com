class AddPinToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :pin, :string, null: true, default: nil
  end
end
