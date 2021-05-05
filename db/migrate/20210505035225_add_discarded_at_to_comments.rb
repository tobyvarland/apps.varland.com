class AddDiscardedAtToComments < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :discarded_at, :datetime, null: true, default: nil
  end
end