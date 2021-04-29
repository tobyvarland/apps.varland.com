class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.references  :user,          null: false,        foreign_key: true
      t.references  :reviewable,    polymorphic: true,  null: false
      t.datetime    :completed_at,  null: true,         default: nil
      t.timestamps
    end
  end
end