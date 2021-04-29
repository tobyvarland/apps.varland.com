class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.references  :user,        null: false,        foreign_key: true
      t.references  :commentable, polymorphic: true,  null: false
      t.text        :body,        null: false
      t.datetime    :comment_at,  null: true,         default: nil
      t.timestamps
    end
  end
end