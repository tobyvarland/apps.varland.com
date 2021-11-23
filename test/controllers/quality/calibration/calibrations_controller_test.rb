require "test_helper"

class Quality::Calibration::CalibrationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @result = quality_calibration_results(:one)
  end

  test "should get index" do
    get quality_calibration_results_url
    assert_response :success
  end

  test "should get new" do
    get new_quality_calibration_result_url
    assert_response :success
  end

  test "should create quality_calibration_result" do
    assert_difference('Quality::Calibration::Calibration.count') do
      post quality_calibration_results_url, params: { quality_calibration_result: { calibrated_on: @result.calibrated_on, device_id: @result.device_id, reason_code_id: @result.reason_code_id, user_id: @result.user_id } }
    end

    assert_redirected_to quality_calibration_result_url(Quality::Calibration::Calibration.last)
  end

  test "should show quality_calibration_result" do
    get quality_calibration_result_url(@result)
    assert_response :success
  end

  test "should get edit" do
    get edit_quality_calibration_result_url(@result)
    assert_response :success
  end

  test "should update quality_calibration_result" do
    patch quality_calibration_result_url(@result), params: { quality_calibration_result: { calibrated_on: @result.calibrated_on, device_id: @result.device_id, reason_code_id: @result.reason_code_id, user_id: @result.user_id } }
    assert_redirected_to quality_calibration_result_url(@result)
  end

  test "should destroy quality_calibration_result" do
    assert_difference('Quality::Calibration::Calibration.count', -1) do
      delete quality_calibration_result_url(@result)
    end

    assert_redirected_to quality_calibration_results_url
  end
end
