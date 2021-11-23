class CreateGroovLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :groov_logs do |t|
      t.string      :type,              null: false
      t.string      :controller_name,   null: false
      t.datetime    :log_at,            null: false
      t.integer     :lane,              null: true,   default: nil
      t.integer     :station,           null: true,   default: nil
      t.references  :shop_order,        null: true,   default: nil, foreign_key: { to_table: :as400_shop_orders }
      t.integer     :load,              null: true,   default: nil
      t.integer     :barrel,            null: true,   default: nil
      t.float       :reading,           null: true,   default: nil
      t.float       :limit,             null: true,   default: nil
      t.float       :low_limit,         null: true,   default: nil
      t.float       :high_limit,        null: true,   default: nil
      t.string      :device,            null: true,   default: nil
      t.text        :json_data,         null: false
      t.timestamps
      t.datetime    :discarded_at,      null: true,   default: nil, index: true
    end
  end
end