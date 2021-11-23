class AddTypeToResults < ActiveRecord::Migration[6.1]
  def change
    add_column :quality_calibration_results, :type, :string, null: false
  end
end
