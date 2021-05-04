class CreateQualityRejectTags < ActiveRecord::Migration[6.1]
  def change
    create_table :quality_reject_tags do |t|
      t.references  :shop_order,          null: false
      t.integer     :number,              null: false
      t.references  :source,              null: true,   default: nil,   foreign_key: { to_table: :quality_reject_tags }
      t.date        :rejected_on,         null: false
      t.references  :user,                null: false
      t.string      :loads_rejected,      null: false
      t.float       :pounds,              null: false
      t.integer     :department,          null: false
      t.string      :defect,              null: false
      t.text        :defect_description,  null: true,   default: nil
      t.string      :cause,               null: false
      t.text        :cause_description,   null: true,   default: nil
      t.boolean     :print_partial_tag,   null: false,  default: false
      t.datetime    :discarded_at,        null: true,   default: nil
      t.timestamps
    end
    add_foreign_key :quality_reject_tags, :users, column: :user_id
    add_foreign_key :quality_reject_tags, :as400_shop_orders, column: :shop_order_id
  end
end