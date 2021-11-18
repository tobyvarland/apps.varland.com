require "application_system_test_case"

class Quality::Calibration::ReasonCodesTest < ApplicationSystemTestCase
  setup do
    @reason_code = quality_calibration_reason_codes(:one)
  end

  test "visiting the index" do
    visit quality_calibration_reason_codes_url
    assert_selector "h1", text: "Quality/Calibration/Reason Codes"
  end

  test "creating a Reason code" do
    visit quality_calibration_reason_codes_url
    click_on "New Quality/Calibration/Reason Code"

    fill_in "Enable notifications", with: @reason_code.enable_notifications
    fill_in "Name", with: @reason_code.name
    click_on "Create Reason code"

    assert_text "Reason code was successfully created"
    click_on "Back"
  end

  test "updating a Reason code" do
    visit quality_calibration_reason_codes_url
    click_on "Edit", match: :first

    fill_in "Enable notifications", with: @reason_code.enable_notifications
    fill_in "Name", with: @reason_code.name
    click_on "Update Reason code"

    assert_text "Reason code was successfully updated"
    click_on "Back"
  end

  test "destroying a Reason code" do
    visit quality_calibration_reason_codes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Reason code was successfully destroyed"
  end
end
