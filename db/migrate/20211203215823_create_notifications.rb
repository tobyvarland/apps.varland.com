class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.references    :user,    null: false,  foreign_key: true
      t.text          :text,    null: false
      t.boolean       :is_read, null: false,  default: false
      t.timestamps
    end
  end
end