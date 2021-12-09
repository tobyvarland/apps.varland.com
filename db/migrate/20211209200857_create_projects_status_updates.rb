class CreateProjectsStatusUpdates < ActiveRecord::Migration[6.1]
  def change
    create_table :projects_status_updates do |t|
      t.references    :user,        null: false,  foreign_key: { to_table: :users }
      t.references    :item,        null: false,  foreign_key: { to_table: :projects_items }
      t.string        :status,      null: false
      t.timestamps
    end
  end
end