class AddSaltSprayFieldsToResults < ActiveRecord::Migration[6.1]
  def change
    add_column :records_results, :salt_added, :float, null: true
    add_column :records_results, :distilled_water_added, :float, null: true
    add_column :records_results, :ph, :float, null: true
    add_column :records_results, :weight, :float, null: true
  end
end