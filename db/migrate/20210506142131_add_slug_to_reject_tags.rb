class AddSlugToRejectTags < ActiveRecord::Migration[6.1]
  def change
    add_column  :quality_reject_tags, :slug,  :string
    add_index   :quality_reject_tags, :slug,  unique: true
  end
end