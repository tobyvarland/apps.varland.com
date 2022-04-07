require "test_helper"

class Groov::Bake::PlatedLoadsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @groov_bake_plated_load = groov_bake_plated_loads(:one)
  end

  test "should get index" do
    get groov_bake_plated_loads_url
    assert_response :success
  end

  test "should get new" do
    get new_groov_bake_plated_load_url
    assert_response :success
  end

  test "should create groov_bake_plated_load" do
    assert_difference('Groov::Bake::PlatedLoad.count') do
      post groov_bake_plated_loads_url, params: { groov_bake_plated_load: { as400_shop_order_id: @groov_bake_plated_load.as400_shop_order_id, bake_within: @groov_bake_plated_load.bake_within, department: @groov_bake_plated_load.department, load_id: @groov_bake_plated_load.load_id, number: @groov_bake_plated_load.number, out_of_plating_at: @groov_bake_plated_load.out_of_plating_at } }
    end

    assert_redirected_to groov_bake_plated_load_url(Groov::Bake::PlatedLoad.last)
  end

  test "should show groov_bake_plated_load" do
    get groov_bake_plated_load_url(@groov_bake_plated_load)
    assert_response :success
  end

  test "should get edit" do
    get edit_groov_bake_plated_load_url(@groov_bake_plated_load)
    assert_response :success
  end

  test "should update groov_bake_plated_load" do
    patch groov_bake_plated_load_url(@groov_bake_plated_load), params: { groov_bake_plated_load: { as400_shop_order_id: @groov_bake_plated_load.as400_shop_order_id, bake_within: @groov_bake_plated_load.bake_within, department: @groov_bake_plated_load.department, load_id: @groov_bake_plated_load.load_id, number: @groov_bake_plated_load.number, out_of_plating_at: @groov_bake_plated_load.out_of_plating_at } }
    assert_redirected_to groov_bake_plated_load_url(@groov_bake_plated_load)
  end

  test "should destroy groov_bake_plated_load" do
    assert_difference('Groov::Bake::PlatedLoad.count', -1) do
      delete groov_bake_plated_load_url(@groov_bake_plated_load)
    end

    assert_redirected_to groov_bake_plated_loads_url
  end
end
