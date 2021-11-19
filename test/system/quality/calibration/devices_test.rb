require "application_system_test_case"

class Quality::Calibration::DevicesTest < ApplicationSystemTestCase
  setup do
    @device = quality_calibration_devices(:one)
  end

  test "visiting the index" do
    visit quality_calibration_devices_url
    assert_selector "h1", text: "Quality/Calibration/Devices"
  end

  test "creating a Device" do
    visit quality_calibration_devices_url
    click_on "New Quality/Calibration/Device"

    fill_in "Category", with: @device.category_id
    fill_in "Discarded at", with: @device.discarded_at
    check "Enable notifications" if @device.enable_notifications
    fill_in "In service on", with: @device.in_service_on
    fill_in "Location", with: @device.location
    fill_in "Name", with: @device.name
    fill_in "Retired on", with: @device.retired_on
    click_on "Create Device"

    assert_text "Device was successfully created"
    click_on "Back"
  end

  test "updating a Device" do
    visit quality_calibration_devices_url
    click_on "Edit", match: :first

    fill_in "Category", with: @device.category_id
    fill_in "Discarded at", with: @device.discarded_at
    check "Enable notifications" if @device.enable_notifications
    fill_in "In service on", with: @device.in_service_on
    fill_in "Location", with: @device.location
    fill_in "Name", with: @device.name
    fill_in "Retired on", with: @device.retired_on
    click_on "Update Device"

    assert_text "Device was successfully updated"
    click_on "Back"
  end

  test "destroying a Device" do
    visit quality_calibration_devices_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Device was successfully destroyed"
  end
end
