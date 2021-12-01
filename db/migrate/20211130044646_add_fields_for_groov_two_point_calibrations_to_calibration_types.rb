class AddFieldsForGroovTwoPointCalibrationsToCalibrationTypes < ActiveRecord::Migration[6.1]
  def change
    add_column :calibrations_calibration_types, :expected_low, :float, null: true
    add_column :calibrations_calibration_types, :expected_high, :float, null: true
  end
end
