require "application_system_test_case"

class Groov::Bake::PlatedLoadsTest < ApplicationSystemTestCase
  setup do
    @groov_bake_plated_load = groov_bake_plated_loads(:one)
  end

  test "visiting the index" do
    visit groov_bake_plated_loads_url
    assert_selector "h1", text: "Groov/Bake/Plated Loads"
  end

  test "creating a Plated load" do
    visit groov_bake_plated_loads_url
    click_on "New Groov/Bake/Plated Load"

    fill_in "AS400 shop order", with: @groov_bake_plated_load.as400_shop_order_id
    fill_in "Bake within", with: @groov_bake_plated_load.bake_within
    fill_in "Department", with: @groov_bake_plated_load.department
    fill_in "Load", with: @groov_bake_plated_load.load_id
    fill_in "Number", with: @groov_bake_plated_load.number
    fill_in "Out of plating at", with: @groov_bake_plated_load.out_of_plating_at
    click_on "Create Plated load"

    assert_text "Plated load was successfully created"
    click_on "Back"
  end

  test "updating a Plated load" do
    visit groov_bake_plated_loads_url
    click_on "Edit", match: :first

    fill_in "AS400 shop order", with: @groov_bake_plated_load.as400_shop_order_id
    fill_in "Bake within", with: @groov_bake_plated_load.bake_within
    fill_in "Department", with: @groov_bake_plated_load.department
    fill_in "Load", with: @groov_bake_plated_load.load_id
    fill_in "Number", with: @groov_bake_plated_load.number
    fill_in "Out of plating at", with: @groov_bake_plated_load.out_of_plating_at
    click_on "Update Plated load"

    assert_text "Plated load was successfully updated"
    click_on "Back"
  end

  test "destroying a Plated load" do
    visit groov_bake_plated_loads_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Plated load was successfully destroyed"
  end
end
