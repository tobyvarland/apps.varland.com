require "test_helper"

class Quality::HardnessTestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @quality_hardness_test = quality_hardness_tests(:one)
  end

  test "should get index" do
    get quality_hardness_tests_url
    assert_response :success
  end

  test "should get new" do
    get new_quality_hardness_test_url
    assert_response :success
  end

  test "should create quality_hardness_test" do
    assert_difference('Quality::HardnessTest.count') do
      post quality_hardness_tests_url, params: { quality_hardness_test: { is_rework: @quality_hardness_test.is_rework, load: @quality_hardness_test.load, piece_1: @quality_hardness_test.piece_1, piece_2: @quality_hardness_test.piece_2, raw_test_id: @quality_hardness_test.raw_test_id, shop_order_id: @quality_hardness_test.shop_order_id, test_type: @quality_hardness_test.test_type, tested_on: @quality_hardness_test.tested_on, user_id: @quality_hardness_test.user_id, oven_type: @quality_hardness_test.oven_type } }
    end

    assert_redirected_to quality_hardness_test_url(Quality::HardnessTest.last)
  end

  test "should show quality_hardness_test" do
    get quality_hardness_test_url(@quality_hardness_test)
    assert_response :success
  end

  test "should get edit" do
    get edit_quality_hardness_test_url(@quality_hardness_test)
    assert_response :success
  end

  test "should update quality_hardness_test" do
    patch quality_hardness_test_url(@quality_hardness_test), params: { quality_hardness_test: { is_rework: @quality_hardness_test.is_rework, load: @quality_hardness_test.load, piece_1: @quality_hardness_test.piece_1, piece_2: @quality_hardness_test.piece_2, raw_test_id: @quality_hardness_test.raw_test_id, shop_order_id: @quality_hardness_test.shop_order_id, test_type: @quality_hardness_test.test_type, tested_on: @quality_hardness_test.tested_on, user_id: @quality_hardness_test.user_id, oven_type: @quality_hardness_test.oven_type } }
    assert_redirected_to quality_hardness_test_url(@quality_hardness_test)
  end

  test "should destroy quality_hardness_test" do
    assert_difference('Quality::HardnessTest.count', -1) do
      delete quality_hardness_test_url(@quality_hardness_test)
    end

    assert_redirected_to quality_hardness_tests_url
  end
end
