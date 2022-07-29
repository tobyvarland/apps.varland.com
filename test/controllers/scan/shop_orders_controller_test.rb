require "test_helper"

class Scan::ShopOrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @scan_shop_order = scan_shop_orders(:one)
  end

  test "should get index" do
    get scan_shop_orders_url
    assert_response :success
  end

  test "should get new" do
    get new_scan_shop_order_url
    assert_response :success
  end

  test "should create scan_shop_order" do
    assert_difference('Scan::ShopOrder.count') do
      post scan_shop_orders_url, params: { scan_shop_order: { document_id: @scan_shop_order.document_id, shop_order_id: @scan_shop_order.shop_order_id } }
    end

    assert_redirected_to scan_shop_order_url(Scan::ShopOrder.last)
  end

  test "should show scan_shop_order" do
    get scan_shop_order_url(@scan_shop_order)
    assert_response :success
  end

  test "should get edit" do
    get edit_scan_shop_order_url(@scan_shop_order)
    assert_response :success
  end

  test "should update scan_shop_order" do
    patch scan_shop_order_url(@scan_shop_order), params: { scan_shop_order: { document_id: @scan_shop_order.document_id, shop_order_id: @scan_shop_order.shop_order_id } }
    assert_redirected_to scan_shop_order_url(@scan_shop_order)
  end

  test "should destroy scan_shop_order" do
    assert_difference('Scan::ShopOrder.count', -1) do
      delete scan_shop_order_url(@scan_shop_order)
    end

    assert_redirected_to scan_shop_orders_url
  end
end
