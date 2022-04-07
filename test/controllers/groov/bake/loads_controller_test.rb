require "test_helper"

class Groov::Bake::LoadsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @groov_bake_load = groov_bake_loads(:one)
  end

  test "should get index" do
    get groov_bake_loads_url
    assert_response :success
  end

  test "should get new" do
    get new_groov_bake_load_url
    assert_response :success
  end

  test "should create groov_bake_load" do
    assert_difference('Groov::Bake::Load.count') do
      post groov_bake_loads_url, params: { groov_bake_load: { in_oven_at: @groov_bake_load.in_oven_at, is_on_bakestand: @groov_bake_load.is_on_bakestand, is_rework: @groov_bake_load.is_rework, number: @groov_bake_load.number, shop_order_id: @groov_bake_load.shop_order_id } }
    end

    assert_redirected_to groov_bake_load_url(Groov::Bake::Load.last)
  end

  test "should show groov_bake_load" do
    get groov_bake_load_url(@groov_bake_load)
    assert_response :success
  end

  test "should get edit" do
    get edit_groov_bake_load_url(@groov_bake_load)
    assert_response :success
  end

  test "should update groov_bake_load" do
    patch groov_bake_load_url(@groov_bake_load), params: { groov_bake_load: { in_oven_at: @groov_bake_load.in_oven_at, is_on_bakestand: @groov_bake_load.is_on_bakestand, is_rework: @groov_bake_load.is_rework, number: @groov_bake_load.number, shop_order_id: @groov_bake_load.shop_order_id } }
    assert_redirected_to groov_bake_load_url(@groov_bake_load)
  end

  test "should destroy groov_bake_load" do
    assert_difference('Groov::Bake::Load.count', -1) do
      delete groov_bake_load_url(@groov_bake_load)
    end

    assert_redirected_to groov_bake_loads_url
  end
end
