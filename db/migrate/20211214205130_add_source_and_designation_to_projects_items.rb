class AddSourceAndDesignationToProjectsItems < ActiveRecord::Migration[6.1]
  def change
    add_column :projects_items, :source, :string, null: true
    add_column :projects_items, :designation, :string, null: true
    add_column :projects_categories, :source_options, :string, null: true
    add_column :projects_categories, :designation_options, :text, null: true
  end
end