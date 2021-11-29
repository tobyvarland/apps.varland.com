class AddCalibrationDueStatusToDevices < ActiveRecord::Migration[6.1]
  def change
    add_column :quality_calibration_devices, :calibration_due_status, :string, null: false
  end
end
