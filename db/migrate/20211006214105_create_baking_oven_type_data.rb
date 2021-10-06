class CreateBakingOvenTypeData < ActiveRecord::Migration[6.1]
  def up
    Baking::OvenType.create(description: "Grieve IAO", is_iao: true, max_trays: 18, max_rods: 60)
    Baking::OvenType.create(description: "JPW IAO", is_iao: true, max_trays: 35, max_rods: 140)
    Baking::OvenType.create(description: "Large Oven", is_iao: false, max_trays: 40, max_rods: 0)
    Baking::OvenType.create(description: "Small Oven", is_iao: false, max_trays: 16, max_rods: 0)
  end
  def down 
    Baking::OvenType.delete_all
  end
end