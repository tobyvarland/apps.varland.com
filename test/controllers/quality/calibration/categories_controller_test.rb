require "test_helper"

class Quality::Calibration::CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @quality_calibration_category = quality_calibration_categories(:one)
  end

  test "should get index" do
    get quality_calibration_categories_url
    assert_response :success
  end

  test "should get new" do
    get new_quality_calibration_category_url
    assert_response :success
  end

  test "should create quality_calibration_category" do
    assert_difference('Quality::Calibration::Category.count') do
      post quality_calibration_categories_url, params: { quality_calibration_category: { calculate_offset_and_gain: @quality_calibration_category.calculate_offset_and_gain, calibration_frequency: @quality_calibration_category.calibration_frequency, discarded_at: @quality_calibration_category.discarded_at, enable_notifications: @quality_calibration_category.enable_notifications, instructions_url: @quality_calibration_category.instructions_url, name: @quality_calibration_category.name, require_gain: @quality_calibration_category.require_gain, require_offset: @quality_calibration_category.require_offset, two_point_high_value: @quality_calibration_category.two_point_high_value, two_point_low_value: @quality_calibration_category.two_point_low_value } }
    end

    assert_redirected_to quality_calibration_category_url(Quality::Calibration::Category.last)
  end

  test "should show quality_calibration_category" do
    get quality_calibration_category_url(@quality_calibration_category)
    assert_response :success
  end

  test "should get edit" do
    get edit_quality_calibration_category_url(@quality_calibration_category)
    assert_response :success
  end

  test "should update quality_calibration_category" do
    patch quality_calibration_category_url(@quality_calibration_category), params: { quality_calibration_category: { calculate_offset_and_gain: @quality_calibration_category.calculate_offset_and_gain, calibration_frequency: @quality_calibration_category.calibration_frequency, discarded_at: @quality_calibration_category.discarded_at, enable_notifications: @quality_calibration_category.enable_notifications, instructions_url: @quality_calibration_category.instructions_url, name: @quality_calibration_category.name, require_gain: @quality_calibration_category.require_gain, require_offset: @quality_calibration_category.require_offset, two_point_high_value: @quality_calibration_category.two_point_high_value, two_point_low_value: @quality_calibration_category.two_point_low_value } }
    assert_redirected_to quality_calibration_category_url(@quality_calibration_category)
  end

  test "should destroy quality_calibration_category" do
    assert_difference('Quality::Calibration::Category.count', -1) do
      delete quality_calibration_category_url(@quality_calibration_category)
    end

    assert_redirected_to quality_calibration_categories_url
  end
end
