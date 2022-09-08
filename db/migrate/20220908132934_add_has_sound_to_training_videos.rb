class AddHasSoundToTrainingVideos < ActiveRecord::Migration[6.1]
  def change
    add_column :training_videos, :has_sound, :boolean, null: false, default: false
  end
end
