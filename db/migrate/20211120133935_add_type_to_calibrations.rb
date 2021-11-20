class AddTypeToCalibrations < ActiveRecord::Migration[6.1]
  def change
    add_column :quality_calibration_calibrations, :type, :string, null: false
  end
end
