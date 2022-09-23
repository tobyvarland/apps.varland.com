require "test_helper"

class Bake::CyclesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bake_cycle = bake_cycles(:one)
  end

  test "should get index" do
    get bake_cycles_url
    assert_response :success
  end

  test "should get new" do
    get new_bake_cycle_url
    assert_response :success
  end

  test "should create bake_cycle" do
    assert_difference('Bake::Cycle.count') do
      post bake_cycles_url, params: { bake_cycle: { cooling_finished_at: @bake_cycle.cooling_finished_at, cycle_ended_at: @bake_cycle.cycle_ended_at, cycle_started_at: @bake_cycle.cycle_started_at, gas_off_at: @bake_cycle.gas_off_at, is_locked: @bake_cycle.is_locked, loadings_finished_at: @bake_cycle.loadings_finished_at, oven: @bake_cycle.oven, psi_consumed: @bake_cycle.psi_consumed, purge_finished_at: @bake_cycle.purge_finished_at, side: @bake_cycle.side, soak_ended_at: @bake_cycle.soak_ended_at, soak_started_at: @bake_cycle.soak_started_at, type: @bake_cycle.type, used_cooling_profile: @bake_cycle.used_cooling_profile, user_id: @bake_cycle.user_id } }
    end

    assert_redirected_to bake_cycle_url(Bake::Cycle.last)
  end

  test "should show bake_cycle" do
    get bake_cycle_url(@bake_cycle)
    assert_response :success
  end

  test "should get edit" do
    get edit_bake_cycle_url(@bake_cycle)
    assert_response :success
  end

  test "should update bake_cycle" do
    patch bake_cycle_url(@bake_cycle), params: { bake_cycle: { cooling_finished_at: @bake_cycle.cooling_finished_at, cycle_ended_at: @bake_cycle.cycle_ended_at, cycle_started_at: @bake_cycle.cycle_started_at, gas_off_at: @bake_cycle.gas_off_at, is_locked: @bake_cycle.is_locked, loadings_finished_at: @bake_cycle.loadings_finished_at, oven: @bake_cycle.oven, psi_consumed: @bake_cycle.psi_consumed, purge_finished_at: @bake_cycle.purge_finished_at, side: @bake_cycle.side, soak_ended_at: @bake_cycle.soak_ended_at, soak_started_at: @bake_cycle.soak_started_at, type: @bake_cycle.type, used_cooling_profile: @bake_cycle.used_cooling_profile, user_id: @bake_cycle.user_id } }
    assert_redirected_to bake_cycle_url(@bake_cycle)
  end

  test "should destroy bake_cycle" do
    assert_difference('Bake::Cycle.count', -1) do
      delete bake_cycle_url(@bake_cycle)
    end

    assert_redirected_to bake_cycles_url
  end
end
