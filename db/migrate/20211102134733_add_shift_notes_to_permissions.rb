class AddShiftNotesToPermissions < ActiveRecord::Migration[6.1]
  def change
    add_column :permissions, :shift_notes, :integer, null: false, default: 0
  end
end
