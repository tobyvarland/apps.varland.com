class CreateQualityCalibrationCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :quality_calibration_categories do |t|
      t.string        :name,                        null: false                     
      t.integer       :calibration_frequency,       null: false
      t.string        :instructions_url,            null: true,   default: nil               
      t.float         :two_point_low_value,         null: true,   default: nil    
      t.float         :two_point_high_value,        null: true,   default: nil
      t.boolean       :calculate_offset_and_gain,   null: true,   default: nil
      t.boolean       :require_offset,              null: true,   default: nil
      t.boolean       :require_gain,                null: true,   default: nil
      t.boolean       :enable_notifications,        null: true,   default: nil
      t.datetime      :discarded_at,                null: true,   default: nil,   index: true
      t.timestamps
    end
  end
end
