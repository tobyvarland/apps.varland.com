class AddRejectTagPermissionToPermissions < ActiveRecord::Migration[6.1]
  def change
    add_column :permissions, :reject_tags, :integer, null: false, default: 1
  end
end