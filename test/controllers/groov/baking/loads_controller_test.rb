require "test_helper"

class Groov::Baking::LoadsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @groov_baking_load = groov_baking_loads(:one)
  end

  test "should get index" do
    get groov_baking_loads_url
    assert_response :success
  end

  test "should get new" do
    get new_groov_baking_load_url
    assert_response :success
  end

  test "should create groov_baking_load" do
    assert_difference('Groov::Baking::Load.count') do
      post groov_baking_loads_url, params: { groov_baking_load: { is_rework: @groov_baking_load.is_rework, number: @groov_baking_load.number, shop_order_id: @groov_baking_load.shop_order_id } }
    end

    assert_redirected_to groov_baking_load_url(Groov::Baking::Load.last)
  end

  test "should show groov_baking_load" do
    get groov_baking_load_url(@groov_baking_load)
    assert_response :success
  end

  test "should get edit" do
    get edit_groov_baking_load_url(@groov_baking_load)
    assert_response :success
  end

  test "should update groov_baking_load" do
    patch groov_baking_load_url(@groov_baking_load), params: { groov_baking_load: { is_rework: @groov_baking_load.is_rework, number: @groov_baking_load.number, shop_order_id: @groov_baking_load.shop_order_id } }
    assert_redirected_to groov_baking_load_url(@groov_baking_load)
  end

  test "should destroy groov_baking_load" do
    assert_difference('Groov::Baking::Load.count', -1) do
      delete groov_baking_load_url(@groov_baking_load)
    end

    assert_redirected_to groov_baking_loads_url
  end
end
