require "test_helper"

class Bake::StandsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bake_stand = bake_stands(:one)
  end

  test "should get index" do
    get bake_stands_url
    assert_response :success
  end

  test "should get new" do
    get new_bake_stand_url
    assert_response :success
  end

  test "should create bake_stand" do
    assert_difference('Bake::Stand.count') do
      post bake_stands_url, params: { bake_stand: { cycle_id: @bake_stand.cycle_id, name: @bake_stand.name, type: @bake_stand.type } }
    end

    assert_redirected_to bake_stand_url(Bake::Stand.last)
  end

  test "should show bake_stand" do
    get bake_stand_url(@bake_stand)
    assert_response :success
  end

  test "should get edit" do
    get edit_bake_stand_url(@bake_stand)
    assert_response :success
  end

  test "should update bake_stand" do
    patch bake_stand_url(@bake_stand), params: { bake_stand: { cycle_id: @bake_stand.cycle_id, name: @bake_stand.name, type: @bake_stand.type } }
    assert_redirected_to bake_stand_url(@bake_stand)
  end

  test "should destroy bake_stand" do
    assert_difference('Bake::Stand.count', -1) do
      delete bake_stand_url(@bake_stand)
    end

    assert_redirected_to bake_stands_url
  end
end
