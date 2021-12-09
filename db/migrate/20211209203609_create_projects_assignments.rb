class CreateProjectsAssignments < ActiveRecord::Migration[6.1]
  def change
    create_table :projects_assignments do |t|
      t.references    :user,        null: false,  foreign_key: { to_table: :users }
      t.references    :item,        null: false,  foreign_key: { to_table: :projects_items }
      t.timestamps
    end
  end
end