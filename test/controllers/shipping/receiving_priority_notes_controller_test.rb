require "test_helper"

class Shipping::ReceivingPriorityNotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @shipping_receiving_priority_note = shipping_receiving_priority_notes(:one)
  end

  test "should get index" do
    get shipping_receiving_priority_notes_url
    assert_response :success
  end

  test "should get new" do
    get new_shipping_receiving_priority_note_url
    assert_response :success
  end

  test "should create shipping_receiving_priority_note" do
    assert_difference('Shipping::ReceivingPriorityNote.count') do
      post shipping_receiving_priority_notes_url, params: { shipping_receiving_priority_note: { completed_at: @shipping_receiving_priority_note.completed_at, completed_by_user_id_id: @shipping_receiving_priority_note.completed_by_user_id_id, request_details: @shipping_receiving_priority_note.request_details, request_type: @shipping_receiving_priority_note.request_type, requested_by_user_id_id: @shipping_receiving_priority_note.requested_by_user_id_id } }
    end

    assert_redirected_to shipping_receiving_priority_note_url(Shipping::ReceivingPriorityNote.last)
  end

  test "should show shipping_receiving_priority_note" do
    get shipping_receiving_priority_note_url(@shipping_receiving_priority_note)
    assert_response :success
  end

  test "should get edit" do
    get edit_shipping_receiving_priority_note_url(@shipping_receiving_priority_note)
    assert_response :success
  end

  test "should update shipping_receiving_priority_note" do
    patch shipping_receiving_priority_note_url(@shipping_receiving_priority_note), params: { shipping_receiving_priority_note: { completed_at: @shipping_receiving_priority_note.completed_at, completed_by_user_id_id: @shipping_receiving_priority_note.completed_by_user_id_id, request_details: @shipping_receiving_priority_note.request_details, request_type: @shipping_receiving_priority_note.request_type, requested_by_user_id_id: @shipping_receiving_priority_note.requested_by_user_id_id } }
    assert_redirected_to shipping_receiving_priority_note_url(@shipping_receiving_priority_note)
  end

  test "should destroy shipping_receiving_priority_note" do
    assert_difference('Shipping::ReceivingPriorityNote.count', -1) do
      delete shipping_receiving_priority_note_url(@shipping_receiving_priority_note)
    end

    assert_redirected_to shipping_receiving_priority_notes_url
  end
end
