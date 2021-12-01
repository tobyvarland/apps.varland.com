class CreateCalibrationsCalibrationTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :calibrations_calibration_types do |t|
      t.string      :name,                null: false
      t.integer     :frequency,           null: true
      t.string      :url,                 null: true
      t.string      :calibration_method,  null: false
      t.boolean     :is_internal,         null: false
      t.timestamps
      t.datetime    :discarded_at,        null: true,   index: true
    end
  end
end
