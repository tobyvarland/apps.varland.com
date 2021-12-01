class CreateCalibrationsReasonCodes < ActiveRecord::Migration[6.1]
  def change
    create_table :calibrations_reason_codes do |t|
      t.string      :name,              null: false
      t.boolean     :require_comment,   null: false,  default: false
      t.timestamps
      t.datetime    :discarded_at,      null: true,   index: true
    end
  end
end