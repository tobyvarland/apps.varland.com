require "test_helper"

class Quality::Calibration::ReasonCodesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @reason_code = quality_calibration_reason_codes(:one)
  end

  test "should get index" do
    get quality_calibration_reason_codes_url
    assert_response :success
  end

  test "should get new" do
    get new_quality_calibration_reason_code_url
    assert_response :success
  end

  test "should create quality_calibration_reason_code" do
    assert_difference('Quality::Calibration::ReasonCode.count') do
      post quality_calibration_reason_codes_url, params: { quality_calibration_reason_code: { enable_notifications: @reason_code.enable_notifications, name: @reason_code.name } }
    end

    assert_redirected_to quality_calibration_reason_code_url(Quality::Calibration::ReasonCode.last)
  end

  test "should show quality_calibration_reason_code" do
    get quality_calibration_reason_code_url(@reason_code)
    assert_response :success
  end

  test "should get edit" do
    get edit_quality_calibration_reason_code_url(@reason_code)
    assert_response :success
  end

  test "should update quality_calibration_reason_code" do
    patch quality_calibration_reason_code_url(@reason_code), params: { quality_calibration_reason_code: { enable_notifications: @reason_code.enable_notifications, name: @reason_code.name } }
    assert_redirected_to quality_calibration_reason_code_url(@reason_code)
  end

  test "should destroy quality_calibration_reason_code" do
    assert_difference('Quality::Calibration::ReasonCode.count', -1) do
      delete quality_calibration_reason_code_url(@reason_code)
    end

    assert_redirected_to quality_calibration_reason_codes_url
  end
end
