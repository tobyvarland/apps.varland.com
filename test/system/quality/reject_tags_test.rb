require "application_system_test_case"

class Quality::RejectTagsTest < ApplicationSystemTestCase
  setup do
    @quality_reject_tag = quality_reject_tags(:one)
  end

  test "visiting the index" do
    visit quality_reject_tags_url
    assert_selector "h1", text: "Quality/Reject Tags"
  end

  test "creating a Reject tag" do
    visit quality_reject_tags_url
    click_on "New Quality/Reject Tag"

    fill_in "Cause", with: @quality_reject_tag.cause
    fill_in "Cause description", with: @quality_reject_tag.cause_description
    fill_in "Defect", with: @quality_reject_tag.defect
    fill_in "Defect description", with: @quality_reject_tag.defect_description
    fill_in "Department", with: @quality_reject_tag.department
    fill_in "Loads rejected", with: @quality_reject_tag.loads_rejected
    fill_in "Number", with: @quality_reject_tag.number
    fill_in "Pounds", with: @quality_reject_tag.pounds
    fill_in "Rejected on", with: @quality_reject_tag.rejected_on
    fill_in "Shop order", with: @quality_reject_tag.shop_order_id
    fill_in "Source", with: @quality_reject_tag.source
    fill_in "User", with: @quality_reject_tag.user_id
    click_on "Create Reject tag"

    assert_text "Reject tag was successfully created"
    click_on "Back"
  end

  test "updating a Reject tag" do
    visit quality_reject_tags_url
    click_on "Edit", match: :first

    fill_in "Cause", with: @quality_reject_tag.cause
    fill_in "Cause description", with: @quality_reject_tag.cause_description
    fill_in "Defect", with: @quality_reject_tag.defect
    fill_in "Defect description", with: @quality_reject_tag.defect_description
    fill_in "Department", with: @quality_reject_tag.department
    fill_in "Loads rejected", with: @quality_reject_tag.loads_rejected
    fill_in "Number", with: @quality_reject_tag.number
    fill_in "Pounds", with: @quality_reject_tag.pounds
    fill_in "Rejected on", with: @quality_reject_tag.rejected_on
    fill_in "Shop order", with: @quality_reject_tag.shop_order_id
    fill_in "Source", with: @quality_reject_tag.source
    fill_in "User", with: @quality_reject_tag.user_id
    click_on "Update Reject tag"

    assert_text "Reject tag was successfully updated"
    click_on "Back"
  end

  test "destroying a Reject tag" do
    visit quality_reject_tags_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Reject tag was successfully destroyed"
  end
end
