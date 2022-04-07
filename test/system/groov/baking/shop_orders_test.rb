require "application_system_test_case"

class Groov::Baking::ShopOrdersTest < ApplicationSystemTestCase
  setup do
    @groov_baking_shop_order = groov_baking_shop_orders(:one)
  end

  test "visiting the index" do
    visit groov_baking_shop_orders_url
    assert_selector "h1", text: "Groov/Baking/Shop Orders"
  end

  test "creating a Shop order" do
    visit groov_baking_shop_orders_url
    click_on "New Groov/Baking/Shop Order"

    fill_in "Cycle", with: @groov_baking_shop_order.cycle_id
    fill_in "Shop order", with: @groov_baking_shop_order.shop_order_id
    click_on "Create Shop order"

    assert_text "Shop order was successfully created"
    click_on "Back"
  end

  test "updating a Shop order" do
    visit groov_baking_shop_orders_url
    click_on "Edit", match: :first

    fill_in "Cycle", with: @groov_baking_shop_order.cycle_id
    fill_in "Shop order", with: @groov_baking_shop_order.shop_order_id
    click_on "Update Shop order"

    assert_text "Shop order was successfully updated"
    click_on "Back"
  end

  test "destroying a Shop order" do
    visit groov_baking_shop_orders_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Shop order was successfully destroyed"
  end
end
