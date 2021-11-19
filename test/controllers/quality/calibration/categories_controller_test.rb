require "test_helper"

class Quality::Calibration::CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = quality_calibration_categories(:one)
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
      post quality_calibration_categories_url, params: { quality_calibration_category: { calculate_offset_and_gain: @category.calculate_offset_and_gain, calibration_frequency: @category.calibration_frequency, discarded_at: @category.discarded_at, enable_notifications: @category.enable_notifications, instructions_url: @category.instructions_url, name: @category.name, require_gain: @category.require_gain, require_offset: @category.require_offset, two_point_high_value: @category.two_point_high_value, two_point_low_value: @category.two_point_low_value } }
    end

    assert_redirected_to quality_calibration_category_url(Quality::Calibration::Category.last)
  end

  test "should show quality_calibration_category" do
    get quality_calibration_category_url(@category)
    assert_response :success
  end

  test "should get edit" do
    get edit_quality_calibration_category_url(@category)
    assert_response :success
  end

  test "should update quality_calibration_category" do
    patch quality_calibration_category_url(@category), params: { quality_calibration_category: { calculate_offset_and_gain: @category.calculate_offset_and_gain, calibration_frequency: @category.calibration_frequency, discarded_at: @category.discarded_at, enable_notifications: @category.enable_notifications, instructions_url: @category.instructions_url, name: @category.name, require_gain: @category.require_gain, require_offset: @category.require_offset, two_point_high_value: @category.two_point_high_value, two_point_low_value: @category.two_point_low_value } }
    assert_redirected_to quality_calibration_category_url(@category)
  end

  test "should destroy quality_calibration_category" do
    assert_difference('Quality::Calibration::Category.count', -1) do
      delete quality_calibration_category_url(@category)
    end

    assert_redirected_to quality_calibration_categories_url
  end
end
