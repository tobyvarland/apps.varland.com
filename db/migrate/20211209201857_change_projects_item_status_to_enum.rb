class ChangeProjectsItemStatusToEnum < ActiveRecord::Migration[6.1]
  def up
    execute "ALTER TABLE `projects_items` MODIFY `status` ENUM('requested', 'opened', 'close_requested', 'closed', 'deleted', 'reopened', 'held');"
    execute "ALTER TABLE `projects_status_updates` MODIFY `status` ENUM('requested', 'opened', 'close_requested', 'closed', 'deleted', 'reopened', 'held');"
  end
  def down
    change_column :projects_items, :status, :string
    change_column :projects_status_updates, :status, :string
  end
end