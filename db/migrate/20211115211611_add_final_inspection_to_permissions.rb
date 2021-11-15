class AddFinalInspectionToPermissions < ActiveRecord::Migration[6.1]
  def change
    add_column :permissions, :final_inspection, :integer, null: false, default: 0
  end
end
