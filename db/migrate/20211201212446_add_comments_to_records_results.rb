class AddCommentsToRecordsResults < ActiveRecord::Migration[6.1]
  def change
    add_column :records_results, :comments, :text, null: true
  end
end