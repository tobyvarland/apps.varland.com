class AddEmployeeNotesToPermissions < ActiveRecord::Migration[6.1]
  def change
    add_column :permissions, :employee_notes, :integer, null: false, default: 0 
  end
end
