require "application_system_test_case"

class Quality::Calibration::CategoriesTest < ApplicationSystemTestCase
  setup do
    @category = quality_calibration_categories(:one)
  end

  test "visiting the index" do
    visit quality_calibration_categories_url
    assert_selector "h1", text: "Quality/Calibration/Categories"
  end

  test "creating a Category" do
    visit quality_calibration_categories_url
    click_on "New Quality/Calibration/Category"

    check "Calculate offset and gain" if @category.calculate_offset_and_gain
    fill_in "Calibration frequency", with: @category.calibration_frequency
    fill_in "Discarded at", with: @category.discarded_at
    check "Enable notifications" if @category.enable_notifications
    fill_in "Instructions url", with: @category.instructions_url
    fill_in "Name", with: @category.name
    check "Require gain" if @category.require_gain
    check "Require offset" if @category.require_offset
    fill_in "Two point high value", with: @category.two_point_high_value
    fill_in "Two point low value", with: @category.two_point_low_value
    click_on "Create Category"

    assert_text "Category was successfully created"
    click_on "Back"
  end

  test "updating a Category" do
    visit quality_calibration_categories_url
    click_on "Edit", match: :first

    check "Calculate offset and gain" if @category.calculate_offset_and_gain
    fill_in "Calibration frequency", with: @category.calibration_frequency
    fill_in "Discarded at", with: @category.discarded_at
    check "Enable notifications" if @category.enable_notifications
    fill_in "Instructions url", with: @category.instructions_url
    fill_in "Name", with: @category.name
    check "Require gain" if @category.require_gain
    check "Require offset" if @category.require_offset
    fill_in "Two point high value", with: @category.two_point_high_value
    fill_in "Two point low value", with: @category.two_point_low_value
    click_on "Update Category"

    assert_text "Category was successfully updated"
    click_on "Back"
  end

  test "destroying a Category" do
    visit quality_calibration_categories_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Category was successfully destroyed"
  end
end
