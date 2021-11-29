class AddDatesToCalibrationDevices < ActiveRecord::Migration[6.1]
  def change
    add_column :quality_calibration_devices, :last_calibrated_on, :date, null: true, default: nil
    add_column :quality_calibration_devices, :next_calibration_due_on, :date, null: true, default: nil
  end
end
