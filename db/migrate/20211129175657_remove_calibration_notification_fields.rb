class RemoveCalibrationNotificationFields < ActiveRecord::Migration[6.1]
  def change
    remove_column :quality_calibration_categories, :enable_notifications
    remove_column :quality_calibration_devices, :enable_notifications
    remove_column :quality_calibration_reason_codes, :enable_notifications
  end
end