require "application_system_test_case"

class Groov::Bake::ContainersTest < ApplicationSystemTestCase
  setup do
    @groov_bake_container = groov_bake_containers(:one)
  end

  test "visiting the index" do
    visit groov_bake_containers_url
    assert_selector "h1", text: "Groov/Bake/Containers"
  end

  test "creating a Container" do
    visit groov_bake_containers_url
    click_on "New Groov/Bake/Container"

    fill_in "Bakestand column", with: @groov_bake_container.bakestand_column
    fill_in "Bakestand row", with: @groov_bake_container.bakestand_row
    fill_in "Description", with: @groov_bake_container.description
    fill_in "Load", with: @groov_bake_container.load_id
    fill_in "Oven shelf", with: @groov_bake_container.oven_shelf
    fill_in "Oven shelf rod position", with: @groov_bake_container.oven_shelf_rod_position
    fill_in "Oven shelf tray position", with: @groov_bake_container.oven_shelf_tray_position
    fill_in "Rod cart position", with: @groov_bake_container.rod_cart_position
    fill_in "Rod cart shelf", with: @groov_bake_container.rod_cart_shelf
    click_on "Create Container"

    assert_text "Container was successfully created"
    click_on "Back"
  end

  test "updating a Container" do
    visit groov_bake_containers_url
    click_on "Edit", match: :first

    fill_in "Bakestand column", with: @groov_bake_container.bakestand_column
    fill_in "Bakestand row", with: @groov_bake_container.bakestand_row
    fill_in "Description", with: @groov_bake_container.description
    fill_in "Load", with: @groov_bake_container.load_id
    fill_in "Oven shelf", with: @groov_bake_container.oven_shelf
    fill_in "Oven shelf rod position", with: @groov_bake_container.oven_shelf_rod_position
    fill_in "Oven shelf tray position", with: @groov_bake_container.oven_shelf_tray_position
    fill_in "Rod cart position", with: @groov_bake_container.rod_cart_position
    fill_in "Rod cart shelf", with: @groov_bake_container.rod_cart_shelf
    click_on "Update Container"

    assert_text "Container was successfully updated"
    click_on "Back"
  end

  test "destroying a Container" do
    visit groov_bake_containers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Container was successfully destroyed"
  end
end
