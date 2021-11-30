class AddFieldsForSaltSprayCollectionRecordToResults < ActiveRecord::Migration[6.1]
  def change
    add_column :calibrations_results, :temperature, :float, null: true
    add_column :calibrations_results, :collection_1_amount, :float, null: true
    add_column :calibrations_results, :collection_1_hours, :float, null: true
    add_column :calibrations_results, :collection_2_amount, :float, null: true
    add_column :calibrations_results, :collection_2_hours, :float, null: true
  end
end
