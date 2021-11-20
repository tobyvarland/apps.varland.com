require "test_helper"

class Quality::Calibration::CalibrationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @calibration = quality_calibration_calibrations(:one)
  end

  test "should get index" do
    get quality_calibration_calibrations_url
    assert_response :success
  end

  test "should get new" do
    get new_quality_calibration_calibration_url
    assert_response :success
  end

  test "should create quality_calibration_calibration" do
    assert_difference('Quality::Calibration::Calibration.count') do
      post quality_calibration_calibrations_url, params: { quality_calibration_calibration: { calibrated_on: @calibration.calibrated_on, calibration_successful: @calibration.calibration_successful, device_id: @calibration.device_id, reason_code_id: @calibration.reason_code_id, user_id: @calibration.user_id } }
    end

    assert_redirected_to quality_calibration_calibration_url(Quality::Calibration::Calibration.last)
  end

  test "should show quality_calibration_calibration" do
    get quality_calibration_calibration_url(@calibration)
    assert_response :success
  end

  test "should get edit" do
    get edit_quality_calibration_calibration_url(@calibration)
    assert_response :success
  end

  test "should update quality_calibration_calibration" do
    patch quality_calibration_calibration_url(@calibration), params: { quality_calibration_calibration: { calibrated_on: @calibration.calibrated_on, calibration_successful: @calibration.calibration_successful, device_id: @calibration.device_id, reason_code_id: @calibration.reason_code_id, user_id: @calibration.user_id } }
    assert_redirected_to quality_calibration_calibration_url(@calibration)
  end

  test "should destroy quality_calibration_calibration" do
    assert_difference('Quality::Calibration::Calibration.count', -1) do
      delete quality_calibration_calibration_url(@calibration)
    end

    assert_redirected_to quality_calibration_calibrations_url
  end
end
