class CreatePermissions < ActiveRecord::Migration[6.1]
  def change
    create_table :permissions do |t|
      t.references  :user,        null: false,  foreign_key: true
      t.boolean     :super_admin, null: false,  default: false
      t.timestamps
    end
    add_index :permissions, :user_id, unique: true, name: "unique_permissions_user"
  end
end