require "application_system_test_case"

class Shipping::ReceivingPriorityNotesTest < ApplicationSystemTestCase
  setup do
    @shipping_receiving_priority_note = shipping_receiving_priority_notes(:one)
  end

  test "visiting the index" do
    visit shipping_receiving_priority_notes_url
    assert_selector "h1", text: "Shipping/Receiving Priority Notes"
  end

  test "creating a Receiving priority note" do
    visit shipping_receiving_priority_notes_url
    click_on "New Shipping/Receiving Priority Note"

    fill_in "Completed at", with: @shipping_receiving_priority_note.completed_at
    fill_in "Completed by user id", with: @shipping_receiving_priority_note.completed_by_user_id_id
    fill_in "Request details", with: @shipping_receiving_priority_note.request_details
    fill_in "Request type", with: @shipping_receiving_priority_note.request_type
    fill_in "Requested by user id", with: @shipping_receiving_priority_note.requested_by_user_id_id
    click_on "Create Receiving priority note"

    assert_text "Receiving priority note was successfully created"
    click_on "Back"
  end

  test "updating a Receiving priority note" do
    visit shipping_receiving_priority_notes_url
    click_on "Edit", match: :first

    fill_in "Completed at", with: @shipping_receiving_priority_note.completed_at
    fill_in "Completed by user id", with: @shipping_receiving_priority_note.completed_by_user_id_id
    fill_in "Request details", with: @shipping_receiving_priority_note.request_details
    fill_in "Request type", with: @shipping_receiving_priority_note.request_type
    fill_in "Requested by user id", with: @shipping_receiving_priority_note.requested_by_user_id_id
    click_on "Update Receiving priority note"

    assert_text "Receiving priority note was successfully updated"
    click_on "Back"
  end

  test "destroying a Receiving priority note" do
    visit shipping_receiving_priority_notes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Receiving priority note was successfully destroyed"
  end
end
