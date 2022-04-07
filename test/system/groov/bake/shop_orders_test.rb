require "application_system_test_case"

class Groov::Bake::ShopOrdersTest < ApplicationSystemTestCase
  setup do
    @groov_bake_shop_order = groov_bake_shop_orders(:one)
  end

  test "visiting the index" do
    visit groov_bake_shop_orders_url
    assert_selector "h1", text: "Groov/Bake/Shop Orders"
  end

  test "creating a Shop order" do
    visit groov_bake_shop_orders_url
    click_on "New Groov/Bake/Shop Order"

    fill_in "AS400 shop order", with: @groov_bake_shop_order.as400_shop_order_id
    fill_in "Bake profile", with: @groov_bake_shop_order.bake_profile
    fill_in "Container type", with: @groov_bake_shop_order.container_type
    fill_in "Cycle", with: @groov_bake_shop_order.cycle_id
    fill_in "Maximum", with: @groov_bake_shop_order.maximum
    fill_in "Minimum", with: @groov_bake_shop_order.minimum
    fill_in "Operation letter", with: @groov_bake_shop_order.operation_letter
    fill_in "Setpoint", with: @groov_bake_shop_order.setpoint
    fill_in "Soak length", with: @groov_bake_shop_order.soak_length
    click_on "Create Shop order"

    assert_text "Shop order was successfully created"
    click_on "Back"
  end

  test "updating a Shop order" do
    visit groov_bake_shop_orders_url
    click_on "Edit", match: :first

    fill_in "AS400 shop order", with: @groov_bake_shop_order.as400_shop_order_id
    fill_in "Bake profile", with: @groov_bake_shop_order.bake_profile
    fill_in "Container type", with: @groov_bake_shop_order.container_type
    fill_in "Cycle", with: @groov_bake_shop_order.cycle_id
    fill_in "Maximum", with: @groov_bake_shop_order.maximum
    fill_in "Minimum", with: @groov_bake_shop_order.minimum
    fill_in "Operation letter", with: @groov_bake_shop_order.operation_letter
    fill_in "Setpoint", with: @groov_bake_shop_order.setpoint
    fill_in "Soak length", with: @groov_bake_shop_order.soak_length
    click_on "Update Shop order"

    assert_text "Shop order was successfully updated"
    click_on "Back"
  end

  test "destroying a Shop order" do
    visit groov_bake_shop_orders_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Shop order was successfully destroyed"
  end
end
