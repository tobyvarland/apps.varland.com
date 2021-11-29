class RemoveUnusedCalibrationCategoryFields < ActiveRecord::Migration[6.1]
  def change
    remove_column :quality_calibration_categories, :calculate_offset_and_gain
    remove_column :quality_calibration_categories, :require_offset
    remove_column :quality_calibration_categories, :require_gain
  end
end