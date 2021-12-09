class CreateProjectsItems < ActiveRecord::Migration[6.1]
  def change
    create_table :projects_items do |t|
      t.references :category,             null: false, foreign_key: { to_table: :projects_categories }
      t.integer :number,                  null: true
      t.string :status,                   null: false
      t.integer :percent_complete,        null: true
      t.integer :priority,                null: true
      t.date :due_on,                     null: true
      t.float :projected_hours,           null: true
      t.timestamps
      t.datetime :discarded_at,           null: true
    end
  end
end