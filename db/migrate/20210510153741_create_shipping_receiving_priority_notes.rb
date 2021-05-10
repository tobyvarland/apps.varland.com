class CreateShippingReceivingPriorityNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :shipping_receiving_priority_notes do |t|
      t.string      :request_type,      null: false
      t.text        :request_details,   null: false
      t.references  :requested_by_user, null: false
      t.references  :completed_by_user, null: true,   default: nil, index: { name: "recnote_req_user" }
      t.datetime    :completed_at,      null: true,   default: nil, index: { name: "recnote_comp_user" }
      t.timestamps
    end
    add_foreign_key :shipping_receiving_priority_notes, :users, column: :requested_by_user_id, name: "fk_recnotes_req_user"
    add_foreign_key :shipping_receiving_priority_notes, :users, column: :completed_by_user_id, name: "fk_recnotes_comp_user"
  end
end