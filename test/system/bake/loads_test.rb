require "application_system_test_case"

class Bake::LoadsTest < ApplicationSystemTestCase
  setup do
    @bake_load = bake_loads(:one)
  end

  test "visiting the index" do
    visit bake_loads_url
    assert_selector "h1", text: "Bake/Loads"
  end

  test "creating a Load" do
    visit bake_loads_url
    click_on "New Bake/Load"

    check "Not loaded" if @bake_load.not_loaded
    fill_in "Number", with: @bake_load.number
    fill_in "Shop order", with: @bake_load.shop_order_id
    fill_in "Started baking at", with: @bake_load.started_baking_at
    click_on "Create Load"

    assert_text "Load was successfully created"
    click_on "Back"
  end

  test "updating a Load" do
    visit bake_loads_url
    click_on "Edit", match: :first

    check "Not loaded" if @bake_load.not_loaded
    fill_in "Number", with: @bake_load.number
    fill_in "Shop order", with: @bake_load.shop_order_id
    fill_in "Started baking at", with: @bake_load.started_baking_at
    click_on "Update Load"

    assert_text "Load was successfully updated"
    click_on "Back"
  end

  test "destroying a Load" do
    visit bake_loads_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Load was successfully destroyed"
  end
end
