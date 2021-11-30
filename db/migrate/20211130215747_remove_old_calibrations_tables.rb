class RemoveOldCalibrationsTables < ActiveRecord::Migration[6.1]
  def change
    drop_table :quality_calibration_results
    drop_table :quality_calibration_reason_codes
    drop_table :quality_calibration_devices
    drop_table :quality_calibration_categories
  end
end