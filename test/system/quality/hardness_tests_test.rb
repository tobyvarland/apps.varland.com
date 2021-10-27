require "application_system_test_case"

class Quality::HardnessTestsTest < ApplicationSystemTestCase
  setup do
    @quality_hardness_test = quality_hardness_tests(:one)
  end

  test "visiting the index" do
    visit quality_hardness_tests_url
    assert_selector "h1", text: "Quality/Hardness Tests"
  end

  test "creating a Hardness test" do
    visit quality_hardness_tests_url
    click_on "New Quality/Hardness Test"

    check "Is rework" if @quality_hardness_test.is_rework
    fill_in "Load", with: @quality_hardness_test.load
    fill_in "Piece 1", with: @quality_hardness_test.piece_1
    fill_in "Piece 2", with: @quality_hardness_test.piece_2
    fill_in "Raw test", with: @quality_hardness_test.raw_test_id
    fill_in "Shop order", with: @quality_hardness_test.shop_order_id
    fill_in "Test type", with: @quality_hardness_test.test_type
    fill_in "Tested on", with: @quality_hardness_test.tested_on
    fill_in "User", with: @quality_hardness_test.user_id
    click_on "Create Hardness test"

    assert_text "Hardness test was successfully created"
    click_on "Back"
  end

  test "updating a Hardness test" do
    visit quality_hardness_tests_url
    click_on "Edit", match: :first

    check "Is rework" if @quality_hardness_test.is_rework
    fill_in "Load", with: @quality_hardness_test.load
    fill_in "Piece 1", with: @quality_hardness_test.piece_1
    fill_in "Piece 2", with: @quality_hardness_test.piece_2
    fill_in "Raw test", with: @quality_hardness_test.raw_test_id
    fill_in "Shop order", with: @quality_hardness_test.shop_order_id
    fill_in "Test type", with: @quality_hardness_test.test_type
    fill_in "Tested on", with: @quality_hardness_test.tested_on
    fill_in "User", with: @quality_hardness_test.user_id
    click_on "Update Hardness test"

    assert_text "Hardness test was successfully updated"
    click_on "Back"
  end

  test "destroying a Hardness test" do
    visit quality_hardness_tests_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Hardness test was successfully destroyed"
  end
end
