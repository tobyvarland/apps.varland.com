require "test_helper"

class Groov::Baking::CyclesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @groov_baking_cycle = groov_baking_cycles(:one)
  end

  test "should get index" do
    get groov_baking_cycles_url
    assert_response :success
  end

  test "should get new" do
    get new_groov_baking_cycle_url
    assert_response :success
  end

  test "should create groov_baking_cycle" do
    assert_difference('Groov::Baking::Cycle.count') do
      post groov_baking_cycles_url, params: { groov_baking_cycle: { bake_type: @groov_baking_cycle.bake_type, cycle_ended_at: @groov_baking_cycle.cycle_ended_at, cycle_started_at: @groov_baking_cycle.cycle_started_at, gas_off_at: @groov_baking_cycle.gas_off_at, maximum: @groov_baking_cycle.maximum, minimum: @groov_baking_cycle.minimum, oven: @groov_baking_cycle.oven, profile_name: @groov_baking_cycle.profile_name, purge_ended_at: @groov_baking_cycle.purge_ended_at, setpoint: @groov_baking_cycle.setpoint, soak_ended_at: @groov_baking_cycle.soak_ended_at, soak_length: @groov_baking_cycle.soak_length, soak_started_at: @groov_baking_cycle.soak_started_at } }
    end

    assert_redirected_to groov_baking_cycle_url(Groov::Baking::Cycle.last)
  end

  test "should show groov_baking_cycle" do
    get groov_baking_cycle_url(@groov_baking_cycle)
    assert_response :success
  end

  test "should get edit" do
    get edit_groov_baking_cycle_url(@groov_baking_cycle)
    assert_response :success
  end

  test "should update groov_baking_cycle" do
    patch groov_baking_cycle_url(@groov_baking_cycle), params: { groov_baking_cycle: { bake_type: @groov_baking_cycle.bake_type, cycle_ended_at: @groov_baking_cycle.cycle_ended_at, cycle_started_at: @groov_baking_cycle.cycle_started_at, gas_off_at: @groov_baking_cycle.gas_off_at, maximum: @groov_baking_cycle.maximum, minimum: @groov_baking_cycle.minimum, oven: @groov_baking_cycle.oven, profile_name: @groov_baking_cycle.profile_name, purge_ended_at: @groov_baking_cycle.purge_ended_at, setpoint: @groov_baking_cycle.setpoint, soak_ended_at: @groov_baking_cycle.soak_ended_at, soak_length: @groov_baking_cycle.soak_length, soak_started_at: @groov_baking_cycle.soak_started_at } }
    assert_redirected_to groov_baking_cycle_url(@groov_baking_cycle)
  end

  test "should destroy groov_baking_cycle" do
    assert_difference('Groov::Baking::Cycle.count', -1) do
      delete groov_baking_cycle_url(@groov_baking_cycle)
    end

    assert_redirected_to groov_baking_cycles_url
  end
end
