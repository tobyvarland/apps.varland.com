require "application_system_test_case"

class Quality::SaltSpray::OptoPostDipsTest < ApplicationSystemTestCase
  setup do
    @opto_post_dip = quality_salt_spray_opto_post_dips(:one)
  end

  test "visiting the index" do
    visit quality_salt_spray_opto_post_dips_url
    assert_selector "h1", text: "Quality/Salt Spray/Opto Post Dips"
  end

  test "creating a Opto post dip" do
    visit quality_salt_spray_opto_post_dips_url
    click_on "New Quality/Salt Spray/Opto Post Dip"

    fill_in "Description", with: @opto_post_dip.description
    fill_in "Dip seconds", with: @opto_post_dip.dip_seconds
    fill_in "Load", with: @opto_post_dip.load
    fill_in "Post dip at", with: @opto_post_dip.post_dip_at
    fill_in "Shop order", with: @opto_post_dip.shop_order_id
    fill_in "Vat", with: @opto_post_dip.vat
    click_on "Create Opto post dip"

    assert_text "Opto post dip was successfully created"
    click_on "Back"
  end

  test "updating a Opto post dip" do
    visit quality_salt_spray_opto_post_dips_url
    click_on "Edit", match: :first

    fill_in "Description", with: @opto_post_dip.description
    fill_in "Dip seconds", with: @opto_post_dip.dip_seconds
    fill_in "Load", with: @opto_post_dip.load
    fill_in "Post dip at", with: @opto_post_dip.post_dip_at
    fill_in "Shop order", with: @opto_post_dip.shop_order_id
    fill_in "Vat", with: @opto_post_dip.vat
    click_on "Update Opto post dip"

    assert_text "Opto post dip was successfully updated"
    click_on "Back"
  end

  test "destroying a Opto post dip" do
    visit quality_salt_spray_opto_post_dips_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Opto post dip was successfully destroyed"
  end
end
