class CreateCalibrationsResults < ActiveRecord::Migration[6.1]
  def change
    create_table :calibrations_results do |t|
      t.string      :type
      t.references  :device,              null: false,  foreign_key: { to_table: :calibrations_devices }
      t.references  :calibration_type,    null: false,  foreign_key: { to_table: :calibrations_calibration_types }
      t.references  :user,                null: false,  foreign_key: { to_table: :users }
      t.references  :reason_code,         null: false,  foreign_key: { to_table: :calibrations_reason_codes }
      t.date        :result_on,           null: false
      t.timestamps
      t.datetime    :discarded_at,        null: true,   index: true
    end
  end
end
