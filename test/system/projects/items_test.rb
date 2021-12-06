require "application_system_test_case"

class Projects::ItemsTest < ApplicationSystemTestCase
  setup do
    @projects_item = projects_items(:one)
  end

  test "visiting the index" do
    visit projects_items_url
    assert_selector "h1", text: "Projects/Items"
  end

  test "creating a Item" do
    visit projects_items_url
    click_on "New Projects/Item"

    fill_in "Category", with: @projects_item.category_id
    fill_in "Current priority", with: @projects_item.current_priority
    fill_in "Current priority at", with: @projects_item.current_priority_at
    fill_in "Current status", with: @projects_item.current_status
    fill_in "Current status at", with: @projects_item.current_status_at
    fill_in "Due on", with: @projects_item.due_on
    fill_in "Number", with: @projects_item.number
    fill_in "Percent complete", with: @projects_item.percent_complete
    fill_in "Projected hours", with: @projects_item.projected_hours
    click_on "Create Item"

    assert_text "Item was successfully created"
    click_on "Back"
  end

  test "updating a Item" do
    visit projects_items_url
    click_on "Edit", match: :first

    fill_in "Category", with: @projects_item.category_id
    fill_in "Current priority", with: @projects_item.current_priority
    fill_in "Current priority at", with: @projects_item.current_priority_at
    fill_in "Current status", with: @projects_item.current_status
    fill_in "Current status at", with: @projects_item.current_status_at
    fill_in "Due on", with: @projects_item.due_on
    fill_in "Number", with: @projects_item.number
    fill_in "Percent complete", with: @projects_item.percent_complete
    fill_in "Projected hours", with: @projects_item.projected_hours
    click_on "Update Item"

    assert_text "Item was successfully updated"
    click_on "Back"
  end

  test "destroying a Item" do
    visit projects_items_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Item was successfully destroyed"
  end
end
