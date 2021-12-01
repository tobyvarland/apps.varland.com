class AddFieldsForHardnessTesterDailyVerificationsToResults < ActiveRecord::Migration[6.1]
  def change
    add_column :calibrations_results, :rockwell_scale, :string, null: true
    add_column :calibrations_results, :test_block_hardness, :float, null: true
    add_column :calibrations_results, :test_block_serial, :string, null: true
    add_column :calibrations_results, :max_error, :float, null: true
    add_column :calibrations_results, :max_repeatability, :float, null: true
    add_column :calibrations_results, :reading_1, :float, null: true
    add_column :calibrations_results, :reading_2, :float, null: true
    add_column :calibrations_calibration_types, :rockwell_scale, :string, null: true
    add_column :calibrations_calibration_types, :test_block_hardness, :float, null: true
    add_column :calibrations_calibration_types, :test_block_serial, :string, null: true
    add_column :calibrations_calibration_types, :max_error, :float, null: true
    add_column :calibrations_calibration_types, :max_repeatability, :float, null: true
  end
end