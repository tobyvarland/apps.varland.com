class AddPayrollAccountIdToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :payroll_account_id, :bigint, null: false, default: 0
  end
end
