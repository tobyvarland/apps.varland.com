class AddFieldsForXrayWeeklyChecksToRecordsResults < ActiveRecord::Migration[6.1]
  def change
    add_column :records_results, :reference, :boolean, null: true
    add_column :records_results, :fwhm_number, :float, null: true
  end
end