class CreateCalibrationsDevices < ActiveRecord::Migration[6.1]
  def change
    create_table :calibrations_devices do |t|
      t.string :name,             null: false
      t.string :location,         null: true
      t.date :in_service_on,      null: false
      t.date :retired_on,         null: true
      t.timestamps
      t.datetime :discarded_at,   null: true,   index: true
    end
  end
end
