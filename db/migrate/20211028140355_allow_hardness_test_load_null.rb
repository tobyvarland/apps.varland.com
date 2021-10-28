class AllowHardnessTestLoadNull < ActiveRecord::Migration[6.1]
  def change
    change_column :quality_hardness_tests, :load, :integer, null: true, default: nil
    change_column :quality_hardness_tests, :is_rework, :boolean, null: true, default: nil
  end
end
