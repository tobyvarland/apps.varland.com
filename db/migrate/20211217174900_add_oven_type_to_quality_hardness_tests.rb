class AddOvenTypeToQualityHardnessTests < ActiveRecord::Migration[6.1]
  def change
    add_column :quality_hardness_tests, :oven_type, :string
  end
end
