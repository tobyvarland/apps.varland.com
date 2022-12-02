class AddForemanFieldsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :aux_foreman, :boolean, null: false, default: false
    add_column :users, :foreman_email_address, :string, null: true, default: nil
  end
end
