require "test_helper"

class Quality::RejectTagsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @quality_reject_tag = quality_reject_tags(:one)
  end

  test "should get index" do
    get quality_reject_tags_url
    assert_response :success
  end

  test "should get new" do
    get new_quality_reject_tag_url
    assert_response :success
  end

  test "should create quality_reject_tag" do
    assert_difference('Quality::RejectTag.count') do
      post quality_reject_tags_url, params: { quality_reject_tag: { cause: @quality_reject_tag.cause, cause_description: @quality_reject_tag.cause_description, defect: @quality_reject_tag.defect, defect_description: @quality_reject_tag.defect_description, department: @quality_reject_tag.department, loads_rejected: @quality_reject_tag.loads_rejected, number: @quality_reject_tag.number, pounds: @quality_reject_tag.pounds, rejected_on: @quality_reject_tag.rejected_on, shop_order_id: @quality_reject_tag.shop_order_id, source: @quality_reject_tag.source, user_id: @quality_reject_tag.user_id } }
    end

    assert_redirected_to quality_reject_tag_url(Quality::RejectTag.last)
  end

  test "should show quality_reject_tag" do
    get quality_reject_tag_url(@quality_reject_tag)
    assert_response :success
  end

  test "should get edit" do
    get edit_quality_reject_tag_url(@quality_reject_tag)
    assert_response :success
  end

  test "should update quality_reject_tag" do
    patch quality_reject_tag_url(@quality_reject_tag), params: { quality_reject_tag: { cause: @quality_reject_tag.cause, cause_description: @quality_reject_tag.cause_description, defect: @quality_reject_tag.defect, defect_description: @quality_reject_tag.defect_description, department: @quality_reject_tag.department, loads_rejected: @quality_reject_tag.loads_rejected, number: @quality_reject_tag.number, pounds: @quality_reject_tag.pounds, rejected_on: @quality_reject_tag.rejected_on, shop_order_id: @quality_reject_tag.shop_order_id, source: @quality_reject_tag.source, user_id: @quality_reject_tag.user_id } }
    assert_redirected_to quality_reject_tag_url(@quality_reject_tag)
  end

  test "should destroy quality_reject_tag" do
    assert_difference('Quality::RejectTag.count', -1) do
      delete quality_reject_tag_url(@quality_reject_tag)
    end

    assert_redirected_to quality_reject_tags_url
  end
end
