class AddGroovTwoPointCalibrationFieldsToResults < ActiveRecord::Migration[6.1]
  def change
    add_column :quality_calibration_results, :two_point_low_value, :float, null: true, default: nil
    add_column :quality_calibration_results, :two_point_low_reading, :float, null: true, default: nil
    add_column :quality_calibration_results, :two_point_high_value, :float, null: true, default: nil
    add_column :quality_calibration_results, :two_point_high_reading, :float, null: true, default: nil
    add_column :quality_calibration_results, :two_point_offset, :float, null: true, default: nil
    add_column :quality_calibration_results, :two_point_gain, :float, null: true, default: nil
  end
end
