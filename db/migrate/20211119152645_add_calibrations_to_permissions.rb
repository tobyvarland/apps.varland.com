class AddCalibrationsToPermissions < ActiveRecord::Migration[6.1]
  def change
    add_column :permissions, :calibrations, :integer, null: false, default: 0
  end
end
