require "application_system_test_case"

class Quality::Calibration::CalibrationsTest < ApplicationSystemTestCase
  setup do
    @calibration = quality_calibration_calibrations(:one)
  end

  test "visiting the index" do
    visit quality_calibration_calibrations_url
    assert_selector "h1", text: "Quality/Calibration/Calibrations"
  end

  test "creating a Calibration" do
    visit quality_calibration_calibrations_url
    click_on "New Quality/Calibration/Calibration"

    fill_in "Calibrated on", with: @calibration.calibrated_on
    check "Calibration successful" if @calibration.calibration_successful
    fill_in "Device", with: @calibration.device_id
    fill_in "Reason code", with: @calibration.reason_code_id
    fill_in "User", with: @calibration.user_id
    click_on "Create Calibration"

    assert_text "Calibration was successfully created"
    click_on "Back"
  end

  test "updating a Calibration" do
    visit quality_calibration_calibrations_url
    click_on "Edit", match: :first

    fill_in "Calibrated on", with: @calibration.calibrated_on
    check "Calibration successful" if @calibration.calibration_successful
    fill_in "Device", with: @calibration.device_id
    fill_in "Reason code", with: @calibration.reason_code_id
    fill_in "User", with: @calibration.user_id
    click_on "Update Calibration"

    assert_text "Calibration was successfully updated"
    click_on "Back"
  end

  test "destroying a Calibration" do
    visit quality_calibration_calibrations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Calibration was successfully destroyed"
  end
end
