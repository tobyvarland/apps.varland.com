class CreateQualityCalibrationDevices < ActiveRecord::Migration[6.1]
  def change
    create_table :quality_calibration_devices do |t|
      t.references          :category,                null: false,    foreign_key: { to_table: :quality_calibration_categories }
      t.string              :name,                    null: false
      t.string              :location,                null: true,     default: nil
      t.date                :in_service_on,           null: false
      t.date                :retired_on,              null: true,     default: nil
      t.boolean             :enable_notifications,    null: false,    default: false     
      t.datetime            :discarded_at,            null: true,     default: nil,  index: true
      t.timestamps
    end
  end
end
