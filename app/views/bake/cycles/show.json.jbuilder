json.(@bake_cycle, :id, :is_locked)
json.ready_to_bake @bake_cycle.ready_to_bake?
json.has_started_baking !@bake_cycle.cycle_started_at.blank?
json.has_finished_baking !@bake_cycle.cycle_ended_at.blank?
json.timestamps do
  json.cycle_started_at @bake_cycle.cycle_started_at
  json.loadings_finished_at @bake_cycle.loadings_finished_at
  json.purge_finished_at @bake_cycle.purge_finished_at
  json.soak_started_at @bake_cycle.soak_started_at
  json.soak_ended_at @bake_cycle.soak_ended_at
  json.gas_off_at @bake_cycle.gas_off_at
  json.cooling_finished_at @bake_cycle.cooling_finished_at
  json.cycle_ended_at @bake_cycle.cycle_ended_at
end
json.employee do
  json.number @bake_cycle.user ? @bake_cycle.user.employee_number : nil
  json.name @bake_cycle.user ? @bake_cycle.user.name : nil
end
json.baking_parameters do
  json.(@bake_cycle, :setpoint, :minimum, :maximum, :soak_hours, :profile_name)
end
json.iao_stats do
  json.(@bake_cycle, :psi_consumed, :used_cooling_profile)
end

json.loadings @bake_cycle.loadings, :container_id, :load_id

json.orders @bake_cycle.shop_orders do |shop_order|
  json.(shop_order, :id, :number, :customer, :process, :part, :sub, :operation, :setpoint, :minimum, :maximum, :soak_hours, :within_hours, :profile_name)
  json.loads shop_order.loads do |load|
    json.(load, :id, :number, :not_loaded, :started_baking_at)
  end
end

json.stands @bake_cycle.stands do |stand|
  json.(stand, :id, :type, :name)
  json.containers stand.containers do |container|
    json.(container, :id, :number, :column, :row)
  end
end