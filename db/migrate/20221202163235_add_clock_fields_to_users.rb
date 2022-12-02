class AddClockFieldsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :clocked_in_at, :datetime, null: true, default: nil
    add_column :users, :is_foreman, :boolean, null: false, default: false
  end
end