class AddInstructionsToRecordsRecordTypes < ActiveRecord::Migration[6.1]
  def change
    add_column :records_record_types, :instructions, :text, null: true
  end
end