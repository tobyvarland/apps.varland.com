class AddFieldsForGroovTwoPointCalibrationsToResults < ActiveRecord::Migration[6.1]
  def change
    add_column :calibrations_results, :expected_low, :float, null: true
    add_column :calibrations_results, :actual_low, :float, null: true
    add_column :calibrations_results, :expected_high, :float, null: true
    add_column :calibrations_results, :actual_high, :float, null: true
    add_column :calibrations_results, :offset, :float, null: true
    add_column :calibrations_results, :gain, :float, null: true
  end
end
