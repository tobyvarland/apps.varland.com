require "test_helper"

class Bake::ShopOrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bake_shop_order = bake_shop_orders(:one)
  end

  test "should get index" do
    get bake_shop_orders_url
    assert_response :success
  end

  test "should get new" do
    get new_bake_shop_order_url
    assert_response :success
  end

  test "should create bake_shop_order" do
    assert_difference('Bake::ShopOrder.count') do
      post bake_shop_orders_url, params: { bake_shop_order: { customer: @bake_shop_order.customer, cycle_id: @bake_shop_order.cycle_id, maximum: @bake_shop_order.maximum, minimum: @bake_shop_order.minimum, number: @bake_shop_order.number, operation: @bake_shop_order.operation, part: @bake_shop_order.part, process: @bake_shop_order.process, profile_name: @bake_shop_order.profile_name, setpoint: @bake_shop_order.setpoint, soak_hours: @bake_shop_order.soak_hours, sub: @bake_shop_order.sub, within_hours: @bake_shop_order.within_hours } }
    end

    assert_redirected_to bake_shop_order_url(Bake::ShopOrder.last)
  end

  test "should show bake_shop_order" do
    get bake_shop_order_url(@bake_shop_order)
    assert_response :success
  end

  test "should get edit" do
    get edit_bake_shop_order_url(@bake_shop_order)
    assert_response :success
  end

  test "should update bake_shop_order" do
    patch bake_shop_order_url(@bake_shop_order), params: { bake_shop_order: { customer: @bake_shop_order.customer, cycle_id: @bake_shop_order.cycle_id, maximum: @bake_shop_order.maximum, minimum: @bake_shop_order.minimum, number: @bake_shop_order.number, operation: @bake_shop_order.operation, part: @bake_shop_order.part, process: @bake_shop_order.process, profile_name: @bake_shop_order.profile_name, setpoint: @bake_shop_order.setpoint, soak_hours: @bake_shop_order.soak_hours, sub: @bake_shop_order.sub, within_hours: @bake_shop_order.within_hours } }
    assert_redirected_to bake_shop_order_url(@bake_shop_order)
  end

  test "should destroy bake_shop_order" do
    assert_difference('Bake::ShopOrder.count', -1) do
      delete bake_shop_order_url(@bake_shop_order)
    end

    assert_redirected_to bake_shop_orders_url
  end
end
