class CreateQualityHardnessTests < ActiveRecord::Migration[6.1]
  def change
    create_table :quality_hardness_tests do |t|
      t.references    :user,             null: false
      t.references    :shop_order,       null: false
      t.references    :raw_test,         null: true,   default: nil,   foreign_key: { to_table: :quality_hardness_tests }
      t.date          :tested_on,        null: false
      t.integer       :load,             null: false
      t.boolean       :is_rework,        null: false,  default: false
      t.string        :test_type,        null: false
      t.float         :piece_1,          null: false
      t.float         :piece_2,          null: false
      t.float         :piece_3,          null: false
      t.float         :piece_4,          null: false
      t.float         :piece_5,          null: false
      t.datetime      :discarded_at,     null: true,    default: nil,   index: true
      t.timestamps
    end
    add_foreign_key :quality_hardness_tests, :users, column: :user_id
    add_foreign_key :quality_hardness_tests, :as400_shop_orders, column: :shop_order_id
  end
end
