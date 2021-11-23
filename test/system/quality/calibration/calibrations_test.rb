require "application_system_test_case"

class Quality::Calibration::CalibrationsTest < ApplicationSystemTestCase
  setup do
    @result = quality_calibration_results(:one)
  end

  test "visiting the index" do
    visit quality_calibration_results_url
    assert_selector "h1", text: "Quality/Calibration/Calibrations"
  end

  test "creating a Calibration" do
    visit quality_calibration_results_url
    click_on "New Quality/Calibration/Calibration"

    fill_in "Calibrated on", with: @result.calibrated_on
    fill_in "Device", with: @result.device_id
    fill_in "Reason code", with: @result.reason_code_id
    fill_in "User", with: @result.user_id
    click_on "Create Calibration"

    assert_text "Calibration was successfully created"
    click_on "Back"
  end

  test "updating a Calibration" do
    visit quality_calibration_results_url
    click_on "Edit", match: :first

    fill_in "Calibrated on", with: @result.calibrated_on
    fill_in "Device", with: @result.device_id
    fill_in "Reason code", with: @result.reason_code_id
    fill_in "User", with: @result.user_id
    click_on "Update Calibration"

    assert_text "Calibration was successfully updated"
    click_on "Back"
  end

  test "destroying a Calibration" do
    visit quality_calibration_results_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Calibration was successfully destroyed"
  end
end
