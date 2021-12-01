class AddDataToRecordsRecordTypes < ActiveRecord::Migration[6.1]
  def change
    add_column :records_record_types, :data_type, :string, null: false
    add_column :records_record_types, :responsibility, :string, null: false
  end
end