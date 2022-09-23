require "application_system_test_case"

class Bake::ContainersTest < ApplicationSystemTestCase
  setup do
    @bake_container = bake_containers(:one)
  end

  test "visiting the index" do
    visit bake_containers_url
    assert_selector "h1", text: "Bake/Containers"
  end

  test "creating a Container" do
    visit bake_containers_url
    click_on "New Bake/Container"

    fill_in "Number", with: @bake_container.number
    fill_in "Stand", with: @bake_container.stand_id
    click_on "Create Container"

    assert_text "Container was successfully created"
    click_on "Back"
  end

  test "updating a Container" do
    visit bake_containers_url
    click_on "Edit", match: :first

    fill_in "Number", with: @bake_container.number
    fill_in "Stand", with: @bake_container.stand_id
    click_on "Update Container"

    assert_text "Container was successfully updated"
    click_on "Back"
  end

  test "destroying a Container" do
    visit bake_containers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Container was successfully destroyed"
  end
end
