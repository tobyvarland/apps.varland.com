require "application_system_test_case"

class Groov::Bake::LoadsTest < ApplicationSystemTestCase
  setup do
    @groov_bake_load = groov_bake_loads(:one)
  end

  test "visiting the index" do
    visit groov_bake_loads_url
    assert_selector "h1", text: "Groov/Bake/Loads"
  end

  test "creating a Load" do
    visit groov_bake_loads_url
    click_on "New Groov/Bake/Load"

    fill_in "In oven at", with: @groov_bake_load.in_oven_at
    check "Is on bakestand" if @groov_bake_load.is_on_bakestand
    check "Is rework" if @groov_bake_load.is_rework
    fill_in "Number", with: @groov_bake_load.number
    fill_in "Shop order", with: @groov_bake_load.shop_order_id
    click_on "Create Load"

    assert_text "Load was successfully created"
    click_on "Back"
  end

  test "updating a Load" do
    visit groov_bake_loads_url
    click_on "Edit", match: :first

    fill_in "In oven at", with: @groov_bake_load.in_oven_at
    check "Is on bakestand" if @groov_bake_load.is_on_bakestand
    check "Is rework" if @groov_bake_load.is_rework
    fill_in "Number", with: @groov_bake_load.number
    fill_in "Shop order", with: @groov_bake_load.shop_order_id
    click_on "Update Load"

    assert_text "Load was successfully updated"
    click_on "Back"
  end

  test "destroying a Load" do
    visit groov_bake_loads_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Load was successfully destroyed"
  end
end
