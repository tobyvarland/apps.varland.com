class MakeCalibrationFrequencyOptional < ActiveRecord::Migration[6.1]
  def change 
    change_column_null :quality_calibration_categories, :calibration_frequency, true
  end
end
