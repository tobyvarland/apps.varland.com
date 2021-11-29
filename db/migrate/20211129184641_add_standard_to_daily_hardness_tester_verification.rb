class AddStandardToDailyHardnessTesterVerification < ActiveRecord::Migration[6.1]
  def change
    add_column :quality_calibration_results, :test_block, :float, null: true, default: nil
  end
end