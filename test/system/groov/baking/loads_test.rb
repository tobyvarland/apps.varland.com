require "application_system_test_case"

class Groov::Baking::LoadsTest < ApplicationSystemTestCase
  setup do
    @groov_baking_load = groov_baking_loads(:one)
  end

  test "visiting the index" do
    visit groov_baking_loads_url
    assert_selector "h1", text: "Groov/Baking/Loads"
  end

  test "creating a Load" do
    visit groov_baking_loads_url
    click_on "New Groov/Baking/Load"

    check "Is rework" if @groov_baking_load.is_rework
    fill_in "Number", with: @groov_baking_load.number
    fill_in "Shop order", with: @groov_baking_load.shop_order_id
    click_on "Create Load"

    assert_text "Load was successfully created"
    click_on "Back"
  end

  test "updating a Load" do
    visit groov_baking_loads_url
    click_on "Edit", match: :first

    check "Is rework" if @groov_baking_load.is_rework
    fill_in "Number", with: @groov_baking_load.number
    fill_in "Shop order", with: @groov_baking_load.shop_order_id
    click_on "Update Load"

    assert_text "Load was successfully updated"
    click_on "Back"
  end

  test "destroying a Load" do
    visit groov_baking_loads_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Load was successfully destroyed"
  end
end
