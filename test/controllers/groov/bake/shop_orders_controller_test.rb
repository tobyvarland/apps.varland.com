require "test_helper"

class Groov::Bake::ShopOrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @groov_bake_shop_order = groov_bake_shop_orders(:one)
  end

  test "should get index" do
    get groov_bake_shop_orders_url
    assert_response :success
  end

  test "should get new" do
    get new_groov_bake_shop_order_url
    assert_response :success
  end

  test "should create groov_bake_shop_order" do
    assert_difference('Groov::Bake::ShopOrder.count') do
      post groov_bake_shop_orders_url, params: { groov_bake_shop_order: { as400_shop_order_id: @groov_bake_shop_order.as400_shop_order_id, bake_profile: @groov_bake_shop_order.bake_profile, container_type: @groov_bake_shop_order.container_type, cycle_id: @groov_bake_shop_order.cycle_id, maximum: @groov_bake_shop_order.maximum, minimum: @groov_bake_shop_order.minimum, operation_letter: @groov_bake_shop_order.operation_letter, setpoint: @groov_bake_shop_order.setpoint, soak_length: @groov_bake_shop_order.soak_length } }
    end

    assert_redirected_to groov_bake_shop_order_url(Groov::Bake::ShopOrder.last)
  end

  test "should show groov_bake_shop_order" do
    get groov_bake_shop_order_url(@groov_bake_shop_order)
    assert_response :success
  end

  test "should get edit" do
    get edit_groov_bake_shop_order_url(@groov_bake_shop_order)
    assert_response :success
  end

  test "should update groov_bake_shop_order" do
    patch groov_bake_shop_order_url(@groov_bake_shop_order), params: { groov_bake_shop_order: { as400_shop_order_id: @groov_bake_shop_order.as400_shop_order_id, bake_profile: @groov_bake_shop_order.bake_profile, container_type: @groov_bake_shop_order.container_type, cycle_id: @groov_bake_shop_order.cycle_id, maximum: @groov_bake_shop_order.maximum, minimum: @groov_bake_shop_order.minimum, operation_letter: @groov_bake_shop_order.operation_letter, setpoint: @groov_bake_shop_order.setpoint, soak_length: @groov_bake_shop_order.soak_length } }
    assert_redirected_to groov_bake_shop_order_url(@groov_bake_shop_order)
  end

  test "should destroy groov_bake_shop_order" do
    assert_difference('Groov::Bake::ShopOrder.count', -1) do
      delete groov_bake_shop_order_url(@groov_bake_shop_order)
    end

    assert_redirected_to groov_bake_shop_orders_url
  end
end
