class AddHardnessTestsToPermissions < ActiveRecord::Migration[6.1]
  def change
    add_column :permissions, :hardness_tests, :integer, null: false, default: 1
  end
end
