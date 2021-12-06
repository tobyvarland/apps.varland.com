class CreateProjectsSystems < ActiveRecord::Migration[6.1]
  def change
    create_table :projects_systems do |t|
      t.string :name,                null: false
      t.string :abbreviation,        null: false           

      t.timestamps
      t.datetime :discarded_at,      null: true
    end
  end
end