class CreateTrainingVideos < ActiveRecord::Migration[6.1]
  def change
    create_table :training_videos do |t|
      t.string      :title,       null: false
      t.text        :description, null: false
      t.string      :url,         null: false
      t.string      :slug,        null: false
      t.timestamps
    end
    add_index :training_videos, :slug,  unique: true
    add_index :training_videos, :title, unique: true
  end
end