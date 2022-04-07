require "test_helper"

class Groov::Baking::ShopOrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @groov_baking_shop_order = groov_baking_shop_orders(:one)
  end

  test "should get index" do
    get groov_baking_shop_orders_url
    assert_response :success
  end

  test "should get new" do
    get new_groov_baking_shop_order_url
    assert_response :success
  end

  test "should create groov_baking_shop_order" do
    assert_difference('Groov::Baking::ShopOrder.count') do
      post groov_baking_shop_orders_url, params: { groov_baking_shop_order: { cycle_id: @groov_baking_shop_order.cycle_id, shop_order_id: @groov_baking_shop_order.shop_order_id } }
    end

    assert_redirected_to groov_baking_shop_order_url(Groov::Baking::ShopOrder.last)
  end

  test "should show groov_baking_shop_order" do
    get groov_baking_shop_order_url(@groov_baking_shop_order)
    assert_response :success
  end

  test "should get edit" do
    get edit_groov_baking_shop_order_url(@groov_baking_shop_order)
    assert_response :success
  end

  test "should update groov_baking_shop_order" do
    patch groov_baking_shop_order_url(@groov_baking_shop_order), params: { groov_baking_shop_order: { cycle_id: @groov_baking_shop_order.cycle_id, shop_order_id: @groov_baking_shop_order.shop_order_id } }
    assert_redirected_to groov_baking_shop_order_url(@groov_baking_shop_order)
  end

  test "should destroy groov_baking_shop_order" do
    assert_difference('Groov::Baking::ShopOrder.count', -1) do
      delete groov_baking_shop_order_url(@groov_baking_shop_order)
    end

    assert_redirected_to groov_baking_shop_orders_url
  end
end
