class CreateRecordsXrayCalibrationChecks < ActiveRecord::Migration[6.1]
  def change
    create_table :records_xray_calibration_checks do |t|
      t.references  :result,    null: false,  foreign_key: { to_table: :records_results }
      t.string      :name,      null: false
      t.string      :action,    null: false
      t.integer     :position,  null: false
      t.timestamps
    end
  end
end