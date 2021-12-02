class AddSlugToRecordsRecordTypes < ActiveRecord::Migration[6.1]
  def change
    add_column :records_record_types, :slug, :string
    add_index :records_record_types, :slug, unique: true
  end
end