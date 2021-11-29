class AddMoreStandardsToDailyHardnessTesterVerification < ActiveRecord::Migration[6.1]
  def change
    add_column :quality_calibration_results, :rockwell_scale, :string, null: true, default: nil
    add_column :quality_calibration_results, :test_block_serial, :string, null: true, default: nil
    add_column :quality_calibration_results, :maximum_error, :float, null: true, default: nil
    add_column :quality_calibration_results, :maximum_repeatability, :float, null: true, default: nil
  end
end