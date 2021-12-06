require "application_system_test_case"

class Projects::CategoriesTest < ApplicationSystemTestCase
  setup do
    @projects_category = projects_categories(:one)
  end

  test "visiting the index" do
    visit projects_categories_url
    assert_selector "h1", text: "Projects/Categories"
  end

  test "creating a Category" do
    visit projects_categories_url
    click_on "New Projects/Category"

    fill_in "Abbreviation", with: @projects_category.abbreviation
    check "Allow children" if @projects_category.allow_children
    check "Allow requests" if @projects_category.allow_requests
    fill_in "Comment sections", with: @projects_category.comment_sections
    fill_in "Last number used", with: @projects_category.last_number_used
    fill_in "Name", with: @projects_category.name
    fill_in "Priority levels", with: @projects_category.priority_levels
    check "Send feedback" if @projects_category.send_feedback
    fill_in "System", with: @projects_category.system_id
    check "Use due date" if @projects_category.use_due_date
    check "Use percent complete" if @projects_category.use_percent_complete
    check "Use reviews" if @projects_category.use_reviews
    check "Use tasks" if @projects_category.use_tasks
    check "Use time tracking" if @projects_category.use_time_tracking
    click_on "Create Category"

    assert_text "Category was successfully created"
    click_on "Back"
  end

  test "updating a Category" do
    visit projects_categories_url
    click_on "Edit", match: :first

    fill_in "Abbreviation", with: @projects_category.abbreviation
    check "Allow children" if @projects_category.allow_children
    check "Allow requests" if @projects_category.allow_requests
    fill_in "Comment sections", with: @projects_category.comment_sections
    fill_in "Last number used", with: @projects_category.last_number_used
    fill_in "Name", with: @projects_category.name
    fill_in "Priority levels", with: @projects_category.priority_levels
    check "Send feedback" if @projects_category.send_feedback
    fill_in "System", with: @projects_category.system_id
    check "Use due date" if @projects_category.use_due_date
    check "Use percent complete" if @projects_category.use_percent_complete
    check "Use reviews" if @projects_category.use_reviews
    check "Use tasks" if @projects_category.use_tasks
    check "Use time tracking" if @projects_category.use_time_tracking
    click_on "Update Category"

    assert_text "Category was successfully updated"
    click_on "Back"
  end

  test "destroying a Category" do
    visit projects_categories_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Category was successfully destroyed"
  end
end
