class AddResultsUpdatedAtToDevices < ActiveRecord::Migration[6.1]
  def change
    add_column :quality_calibration_devices, :results_updated_at, :datetime, null: true, default: nil
  end
end
