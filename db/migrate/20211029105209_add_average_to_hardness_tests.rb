class AddAverageToHardnessTests < ActiveRecord::Migration[6.1]
  def change
    add_column :quality_hardness_tests, :average, :float
  end
end