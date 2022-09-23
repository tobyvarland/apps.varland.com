require "application_system_test_case"

class Bake::StandsTest < ApplicationSystemTestCase
  setup do
    @bake_stand = bake_stands(:one)
  end

  test "visiting the index" do
    visit bake_stands_url
    assert_selector "h1", text: "Bake/Stands"
  end

  test "creating a Stand" do
    visit bake_stands_url
    click_on "New Bake/Stand"

    fill_in "cycle", with: @bake_stand.cycle_id
    fill_in "Name", with: @bake_stand.name
    fill_in "Type", with: @bake_stand.type
    click_on "Create Stand"

    assert_text "Stand was successfully created"
    click_on "Back"
  end

  test "updating a Stand" do
    visit bake_stands_url
    click_on "Edit", match: :first

    fill_in "cycle", with: @bake_stand.cycle_id
    fill_in "Name", with: @bake_stand.name
    fill_in "Type", with: @bake_stand.type
    click_on "Update Stand"

    assert_text "Stand was successfully updated"
    click_on "Back"
  end

  test "destroying a Stand" do
    visit bake_stands_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Stand was successfully destroyed"
  end
end
