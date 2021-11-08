class CreateQualitySaltSprayOptoPostDips < ActiveRecord::Migration[6.1]
  def change
    create_table :quality_salt_spray_opto_post_dips do |t|
      t.references  :shop_order,  null: false,  foreign_key: { to_table: :as400_shop_orders }
      t.datetime    :post_dip_at, null: false
      t.string      :vat,         null: false
      t.string      :description, null: true,   default: nil
      t.integer     :load,        null: false
      t.float       :dip_seconds, null: false
      t.timestamps
    end
  end
end