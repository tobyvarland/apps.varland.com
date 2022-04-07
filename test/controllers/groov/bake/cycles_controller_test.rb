require "test_helper"

class Groov::Bake::CyclesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @groov_bake_cycle = groov_bake_cycles(:one)
  end

  test "should get index" do
    get groov_bake_cycles_url
    assert_response :success
  end

  test "should get new" do
    get new_groov_bake_cycle_url
    assert_response :success
  end

  test "should create groov_bake_cycle" do
    assert_difference('Groov::Bake::Cycle.count') do
      post groov_bake_cycles_url, params: { groov_bake_cycle: { bake_profile: @groov_bake_cycle.bake_profile, bakestand_number: @groov_bake_cycle.bakestand_number, cycle_ended_at: @groov_bake_cycle.cycle_ended_at, cycle_started_at: @groov_bake_cycle.cycle_started_at, discarded_at: @groov_bake_cycle.discarded_at, gas_off_at: @groov_bake_cycle.gas_off_at, loading_finished_at: @groov_bake_cycle.loading_finished_at, maximum: @groov_bake_cycle.maximum, minimum: @groov_bake_cycle.minimum, oven: @groov_bake_cycle.oven, oven_type: @groov_bake_cycle.oven_type, purge_ended_at: @groov_bake_cycle.purge_ended_at, rod_cart_number: @groov_bake_cycle.rod_cart_number, setpoint: @groov_bake_cycle.setpoint, side: @groov_bake_cycle.side, soak_ended_at: @groov_bake_cycle.soak_ended_at, soak_length: @groov_bake_cycle.soak_length, soak_started_at: @groov_bake_cycle.soak_started_at } }
    end

    assert_redirected_to groov_bake_cycle_url(Groov::Bake::Cycle.last)
  end

  test "should show groov_bake_cycle" do
    get groov_bake_cycle_url(@groov_bake_cycle)
    assert_response :success
  end

  test "should get edit" do
    get edit_groov_bake_cycle_url(@groov_bake_cycle)
    assert_response :success
  end

  test "should update groov_bake_cycle" do
    patch groov_bake_cycle_url(@groov_bake_cycle), params: { groov_bake_cycle: { bake_profile: @groov_bake_cycle.bake_profile, bakestand_number: @groov_bake_cycle.bakestand_number, cycle_ended_at: @groov_bake_cycle.cycle_ended_at, cycle_started_at: @groov_bake_cycle.cycle_started_at, discarded_at: @groov_bake_cycle.discarded_at, gas_off_at: @groov_bake_cycle.gas_off_at, loading_finished_at: @groov_bake_cycle.loading_finished_at, maximum: @groov_bake_cycle.maximum, minimum: @groov_bake_cycle.minimum, oven: @groov_bake_cycle.oven, oven_type: @groov_bake_cycle.oven_type, purge_ended_at: @groov_bake_cycle.purge_ended_at, rod_cart_number: @groov_bake_cycle.rod_cart_number, setpoint: @groov_bake_cycle.setpoint, side: @groov_bake_cycle.side, soak_ended_at: @groov_bake_cycle.soak_ended_at, soak_length: @groov_bake_cycle.soak_length, soak_started_at: @groov_bake_cycle.soak_started_at } }
    assert_redirected_to groov_bake_cycle_url(@groov_bake_cycle)
  end

  test "should destroy groov_bake_cycle" do
    assert_difference('Groov::Bake::Cycle.count', -1) do
      delete groov_bake_cycle_url(@groov_bake_cycle)
    end

    assert_redirected_to groov_bake_cycles_url
  end
end
