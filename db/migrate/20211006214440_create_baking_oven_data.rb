class CreateBakingOvenData < ActiveRecord::Migration[6.1]
  def up
    grieve_type = Baking::OvenType.where(description: "Grieve IAO").first
    jpw_type = Baking::OvenType.where(description: "JPW IAO").first
    large_type = Baking::OvenType.where(description: "Large Oven").first
    small_type = Baking::OvenType.where(description: "Small Oven").first
    Baking::Oven.create(oven_type_id: grieve_type.id, description: "Grieve IAO", is_left_side: false)
    Baking::Oven.create(oven_type_id: jpw_type.id, description: "JPW IAO", is_left_side: false)
    Baking::Oven.create(oven_type_id: small_type.id, description: "Oven #1", is_left_side: false)
    Baking::Oven.create(oven_type_id: small_type.id, description: "Oven #3", is_left_side: false)
    Baking::Oven.create(oven_type_id: large_type.id, description: "Oven #6 (Left)", is_left_side: true)
    Baking::Oven.create(oven_type_id: large_type.id, description: "Oven #6 (Right)", is_left_side: false)
    Baking::Oven.create(oven_type_id: large_type.id, description: "Oven #7 (Left)", is_left_side: true)
    Baking::Oven.create(oven_type_id: large_type.id, description: "Oven #7 (Right)", is_left_side: false)
    Baking::Oven.create(oven_type_id: large_type.id, description: "Oven #8 (Left)", is_left_side: true)
    Baking::Oven.create(oven_type_id: large_type.id, description: "Oven #8 (Right)", is_left_side: false)
    Baking::Oven.create(oven_type_id: large_type.id, description: "Oven #9 (Left)", is_left_side: true)
    Baking::Oven.create(oven_type_id: large_type.id, description: "Oven #9 (Right)", is_left_side: false)
  end
  def down 
    Baking::Oven.delete_all
  end
end