class AddDescriptionToGroovLogs < ActiveRecord::Migration[6.1]
  def change
    add_column :groov_logs, :description, :text, null: true, default: nil
  end
end