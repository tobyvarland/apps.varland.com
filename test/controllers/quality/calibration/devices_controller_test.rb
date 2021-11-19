require "test_helper"

class Quality::Calibration::DevicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @device = quality_calibration_devices(:one)
  end

  test "should get index" do
    get quality_calibration_devices_url
    assert_response :success
  end

  test "should get new" do
    get new_quality_calibration_device_url
    assert_response :success
  end

  test "should create quality_calibration_device" do
    assert_difference('Quality::Calibration::Device.count') do
      post quality_calibration_devices_url, params: { quality_calibration_device: { category_id: @device.category_id, discarded_at: @device.discarded_at, enable_notifications: @device.enable_notifications, in_service_on: @device.in_service_on, location: @device.location, name: @device.name, retired_on: @device.retired_on } }
    end

    assert_redirected_to quality_calibration_device_url(Quality::Calibration::Device.last)
  end

  test "should show quality_calibration_device" do
    get quality_calibration_device_url(@device)
    assert_response :success
  end

  test "should get edit" do
    get edit_quality_calibration_device_url(@device)
    assert_response :success
  end

  test "should update quality_calibration_device" do
    patch quality_calibration_device_url(@device), params: { quality_calibration_device: { category_id: @device.category_id, discarded_at: @device.discarded_at, enable_notifications: @device.enable_notifications, in_service_on: @device.in_service_on, location: @device.location, name: @device.name, retired_on: @device.retired_on } }
    assert_redirected_to quality_calibration_device_url(@device)
  end

  test "should destroy quality_calibration_device" do
    assert_difference('Quality::Calibration::Device.count', -1) do
      delete quality_calibration_device_url(@device)
    end

    assert_redirected_to quality_calibration_devices_url
  end
end
