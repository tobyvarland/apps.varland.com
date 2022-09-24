require "application_system_test_case"

class Bake::ShopOrdersTest < ApplicationSystemTestCase
  setup do
    @bake_shop_order = bake_shop_orders(:one)
  end

  test "visiting the index" do
    visit bake_shop_orders_url
    assert_selector "h1", text: "Bake/Shop Orders"
  end

  test "creating a Shop order" do
    visit bake_shop_orders_url
    click_on "New Bake/Shop Order"

    fill_in "Customer", with: @bake_shop_order.customer
    fill_in "Cycle", with: @bake_shop_order.cycle_id
    fill_in "Maximum", with: @bake_shop_order.maximum
    fill_in "Minimum", with: @bake_shop_order.minimum
    fill_in "Number", with: @bake_shop_order.number
    fill_in "Operation", with: @bake_shop_order.operation
    fill_in "Part", with: @bake_shop_order.part
    fill_in "Process", with: @bake_shop_order.process
    fill_in "Profile name", with: @bake_shop_order.profile_name
    fill_in "Setpoint", with: @bake_shop_order.setpoint
    fill_in "Soak hours", with: @bake_shop_order.soak_hours
    fill_in "Sub", with: @bake_shop_order.sub
    fill_in "Within hours", with: @bake_shop_order.within_hours
    click_on "Create Shop order"

    assert_text "Shop order was successfully created"
    click_on "Back"
  end

  test "updating a Shop order" do
    visit bake_shop_orders_url
    click_on "Edit", match: :first

    fill_in "Customer", with: @bake_shop_order.customer
    fill_in "Cycle", with: @bake_shop_order.cycle_id
    fill_in "Maximum", with: @bake_shop_order.maximum
    fill_in "Minimum", with: @bake_shop_order.minimum
    fill_in "Number", with: @bake_shop_order.number
    fill_in "Operation", with: @bake_shop_order.operation
    fill_in "Part", with: @bake_shop_order.part
    fill_in "Process", with: @bake_shop_order.process
    fill_in "Profile name", with: @bake_shop_order.profile_name
    fill_in "Setpoint", with: @bake_shop_order.setpoint
    fill_in "Soak hours", with: @bake_shop_order.soak_hours
    fill_in "Sub", with: @bake_shop_order.sub
    fill_in "Within hours", with: @bake_shop_order.within_hours
    click_on "Update Shop order"

    assert_text "Shop order was successfully updated"
    click_on "Back"
  end

  test "destroying a Shop order" do
    visit bake_shop_orders_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Shop order was successfully destroyed"
  end
end
