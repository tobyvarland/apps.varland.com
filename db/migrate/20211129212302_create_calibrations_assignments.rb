class CreateCalibrationsAssignments < ActiveRecord::Migration[6.1]
  def change
    create_table :calibrations_assignments do |t|
      t.references  :device,                    null: false,  foreign_key: { to_table: :calibrations_devices }
      t.references  :calibration_type,          null: false,  foreign_key: { to_table: :calibrations_calibration_types }
      t.datetime    :results_updated_at,        null: true
      t.date        :last_result_on,            null: true
      t.datetime    :next_result_due_on,        null: true
      t.integer     :next_result_due_in_days,   null: true
      t.timestamps
      t.datetime    :discarded_at,              null: true,   index: true
    end
  end
end