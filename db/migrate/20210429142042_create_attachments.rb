class CreateAttachments < ActiveRecord::Migration[6.1]
  def change
    create_table :attachments do |t|
      t.references  :attachable,  polymorphic: true,  null: false
      t.string      :name,        null: true,         default: nil
      t.text        :description, null: true,         default: nil
      t.timestamps
    end
  end
end