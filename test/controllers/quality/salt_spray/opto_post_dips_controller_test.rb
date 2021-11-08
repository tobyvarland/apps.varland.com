require "test_helper"

class Quality::SaltSpray::OptoPostDipsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @opto_post_dip = quality_salt_spray_opto_post_dips(:one)
  end

  test "should get index" do
    get quality_salt_spray_opto_post_dips_url
    assert_response :success
  end

  test "should get new" do
    get new_quality_salt_spray_opto_post_dip_url
    assert_response :success
  end

  test "should create quality_salt_spray_opto_post_dip" do
    assert_difference('Quality::SaltSpray::OptoPostDip.count') do
      post quality_salt_spray_opto_post_dips_url, params: { quality_salt_spray_opto_post_dip: { description: @opto_post_dip.description, dip_seconds: @opto_post_dip.dip_seconds, load: @opto_post_dip.load, post_dip_at: @opto_post_dip.post_dip_at, shop_order_id: @opto_post_dip.shop_order_id, vat: @opto_post_dip.vat } }
    end

    assert_redirected_to quality_salt_spray_opto_post_dip_url(Quality::SaltSpray::OptoPostDip.last)
  end

  test "should show quality_salt_spray_opto_post_dip" do
    get quality_salt_spray_opto_post_dip_url(@opto_post_dip)
    assert_response :success
  end

  test "should get edit" do
    get edit_quality_salt_spray_opto_post_dip_url(@opto_post_dip)
    assert_response :success
  end

  test "should update quality_salt_spray_opto_post_dip" do
    patch quality_salt_spray_opto_post_dip_url(@opto_post_dip), params: { quality_salt_spray_opto_post_dip: { description: @opto_post_dip.description, dip_seconds: @opto_post_dip.dip_seconds, load: @opto_post_dip.load, post_dip_at: @opto_post_dip.post_dip_at, shop_order_id: @opto_post_dip.shop_order_id, vat: @opto_post_dip.vat } }
    assert_redirected_to quality_salt_spray_opto_post_dip_url(@opto_post_dip)
  end

  test "should destroy quality_salt_spray_opto_post_dip" do
    assert_difference('Quality::SaltSpray::OptoPostDip.count', -1) do
      delete quality_salt_spray_opto_post_dip_url(@opto_post_dip)
    end

    assert_redirected_to quality_salt_spray_opto_post_dips_url
  end
end
