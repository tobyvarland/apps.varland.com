require "application_system_test_case"

class Projects::SystemsTest < ApplicationSystemTestCase
  setup do
    @projects_system = projects_systems(:one)
  end

  test "visiting the index" do
    visit projects_systems_url
    assert_selector "h1", text: "Projects/Systems"
  end

  test "creating a System" do
    visit projects_systems_url
    click_on "New Projects/System"

    fill_in "Abbreviation", with: @projects_system.abbreviation
    fill_in "Name", with: @projects_system.name
    click_on "Create System"

    assert_text "System was successfully created"
    click_on "Back"
  end

  test "updating a System" do
    visit projects_systems_url
    click_on "Edit", match: :first

    fill_in "Abbreviation", with: @projects_system.abbreviation
    fill_in "Name", with: @projects_system.name
    click_on "Update System"

    assert_text "System was successfully updated"
    click_on "Back"
  end

  test "destroying a System" do
    visit projects_systems_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "System was successfully destroyed"
  end
end
