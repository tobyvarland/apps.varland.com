class CreateBakingStandData < ActiveRecord::Migration[6.1]
  def up
    grieve_type = Baking::OvenType.where(description: "Grieve IAO").first
    jpw_type = Baking::OvenType.where(description: "JPW IAO").first
    large_type = Baking::OvenType.where(description: "Large Oven").first
    small_type = Baking::OvenType.where(description: "Small Oven").first
    (1..5).each do |n|
      stand = Baking::Stand.create(number: n, stand_type: :small)
      Baking::StandAssignment.create(oven_type_id: small_type.id, stand_id: stand.id)
    end
    (6..10).each do |n|
      stand = Baking::Stand.create(number: n, stand_type: :large)
      Baking::StandAssignment.create(oven_type_id: large_type.id, stand_id: stand.id)
    end
    (11..15).each do |n|
      stand = Baking::Stand.create(number: n, stand_type: :iao)
      Baking::StandAssignment.create(oven_type_id: grieve_type.id, stand_id: stand.id)
      Baking::StandAssignment.create(oven_type_id: jpw_type.id, stand_id: stand.id)
    end
    (16..20).each do |n|
      stand = Baking::Stand.create(number: n, stand_type: :rods)
      Baking::StandAssignment.create(oven_type_id: grieve_type.id, stand_id: stand.id)
      Baking::StandAssignment.create(oven_type_id: jpw_type.id, stand_id: stand.id)
    end
  end
  def down 
    Baking::StandAssignment.delete_all
    Baking::Stand.delete_all
  end
end