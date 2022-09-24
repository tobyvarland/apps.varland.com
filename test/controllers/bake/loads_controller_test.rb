require "test_helper"

class Bake::LoadsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bake_load = bake_loads(:one)
  end

  test "should get index" do
    get bake_loads_url
    assert_response :success
  end

  test "should get new" do
    get new_bake_load_url
    assert_response :success
  end

  test "should create bake_load" do
    assert_difference('Bake::Load.count') do
      post bake_loads_url, params: { bake_load: { not_loaded: @bake_load.not_loaded, number: @bake_load.number, shop_order_id: @bake_load.shop_order_id, started_baking_at: @bake_load.started_baking_at } }
    end

    assert_redirected_to bake_load_url(Bake::Load.last)
  end

  test "should show bake_load" do
    get bake_load_url(@bake_load)
    assert_response :success
  end

  test "should get edit" do
    get edit_bake_load_url(@bake_load)
    assert_response :success
  end

  test "should update bake_load" do
    patch bake_load_url(@bake_load), params: { bake_load: { not_loaded: @bake_load.not_loaded, number: @bake_load.number, shop_order_id: @bake_load.shop_order_id, started_baking_at: @bake_load.started_baking_at } }
    assert_redirected_to bake_load_url(@bake_load)
  end

  test "should destroy bake_load" do
    assert_difference('Bake::Load.count', -1) do
      delete bake_load_url(@bake_load)
    end

    assert_redirected_to bake_loads_url
  end
end
