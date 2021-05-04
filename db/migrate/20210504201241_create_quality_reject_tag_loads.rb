class CreateQualityRejectTagLoads < ActiveRecord::Migration[6.1]
  def change
    create_table :quality_reject_tag_loads do |t|
      t.references  :reject_tag,  null: false,  foreign_key: { to_table: :quality_reject_tags }
      t.integer     :number,      null: false
      t.integer     :barrel,      null: true,   default: nil
      t.integer     :station,     null: true,   default: nil
      t.timestamps
    end
  end
end