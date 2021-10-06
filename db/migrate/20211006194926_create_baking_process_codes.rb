class CreateBakingProcessCodes < ActiveRecord::Migration[6.1]
  def change
    create_table :baking_process_codes do |t|
      t.string      :code
      t.boolean     :is_allowed_on_left_side
      t.timestamps
    end
  end
end