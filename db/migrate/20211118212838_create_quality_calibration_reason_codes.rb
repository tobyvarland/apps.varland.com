class CreateQualityCalibrationReasonCodes < ActiveRecord::Migration[6.1]
  def change
    create_table :quality_calibration_reason_codes do |t|
      t.string :name,                null: false
      t.boolean :enable_notifications, null: false,  default: false
      t.datetime :discarded_at,     null: true,   default: nil,   index: true
      t.timestamps
    end
  end
end
