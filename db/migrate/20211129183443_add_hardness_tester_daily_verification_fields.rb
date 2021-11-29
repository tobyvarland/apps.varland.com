class AddHardnessTesterDailyVerificationFields < ActiveRecord::Migration[6.1]
  def change
    add_column :quality_calibration_categories, :rockwell_scale, :string, null: true, default: nil
    add_column :quality_calibration_categories, :test_block_hardness, :float, null: true, default: nil
    add_column :quality_calibration_categories, :test_block_serial, :string, null: true, default: nil
    add_column :quality_calibration_categories, :maximum_error, :float, null: true, default: nil
    add_column :quality_calibration_categories, :maximum_repeatability, :float, null: true, default: nil
    add_column :quality_calibration_results, :reading_1, :float, null: true, default: nil
    add_column :quality_calibration_results, :reading_2, :float, null: true, default: nil
  end
end