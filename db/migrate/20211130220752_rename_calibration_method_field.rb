class RenameCalibrationMethodField < ActiveRecord::Migration[6.1]
  def change
    rename_column :records_record_types, :calibration_method, :record_subclass
  end
end