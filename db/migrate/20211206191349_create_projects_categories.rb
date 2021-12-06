class CreateProjectsCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :projects_categories do |t|
      t.references        :system,               null: false, foreign_key: { to_table: :projects_systems }
      t.string            :name,                 null: false
      t.string            :abbreviation,         null: false
      t.integer           :last_number_used,     null: false 
      t.string            :comment_sections,     null: false 
      t.boolean           :use_priorities,       null: false 
      t.boolean           :use_tasks,            null: false 
      t.boolean           :use_time_tracking,    null: false
      t.boolean           :use_reviews,          null: false 
      t.boolean           :use_percent_complete, null: false
      t.boolean           :allow_children,       null: false
      t.boolean           :allow_requests,       null: false 
      t.boolean           :send_feedback,        null: false
      t.boolean           :use_due_date,         null: false 
      t.timestamps        
      t.datetime          :discarded_at,         null: true
    end
  end
end