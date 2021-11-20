class AddCalibrationMethodToCategories < ActiveRecord::Migration[6.1]
  def change
    add_column :quality_calibration_categories, :calibration_method, :string, null: false
  end
end
