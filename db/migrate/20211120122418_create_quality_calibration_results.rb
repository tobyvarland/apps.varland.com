class CreateQualityCalibrationResults < ActiveRecord::Migration[6.1]
  def change
    create_table :quality_calibration_results do |t|
      t.references              :device,                    null: false, foreign_key: { to_table: :quality_calibration_devices }
      t.references              :user,                      null: false, foreign_key: true
      t.references              :reason_code,               null: false, foreign_key: { to_table: :quality_calibration_reason_codes }
      t.date                    :calibrated_on,             null: false
      t.datetime                :discarded_at,              null: true,  default: nil, index: true
      t.timestamps
    end
  end
end
