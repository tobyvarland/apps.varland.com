class AddUserToGroovLogs < ActiveRecord::Migration[6.1]
  def change
    add_reference :groov_logs, :user, null: true, default: nil, foreign_key: { to_table: :users }
  end
end
