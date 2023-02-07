class AddRejectReasonToQualityRejectTags < ActiveRecord::Migration[6.1]
  def change
    add_column :quality_reject_tags, :reason, :string, null: true, default: nil
  end
end
