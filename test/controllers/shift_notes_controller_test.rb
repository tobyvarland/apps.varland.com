require "test_helper"

class ShiftNotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @shift_note = shift_notes(:one)
  end

  test "should get index" do
    get shift_notes_url
    assert_response :success
  end

  test "should get new" do
    get new_shift_note_url
    assert_response :success
  end

  test "should create shift_note" do
    assert_difference('ShiftNote.count') do
      post shift_notes_url, params: { shift_note: { department: @shift_note.department, discarded_at: @shift_note.discarded_at, is_for_it: @shift_note.is_for_it, is_for_lab: @shift_note.is_for_lab, is_for_maintenance: @shift_note.is_for_maintenance, is_for_plating: @shift_note.is_for_plating, is_for_qc: @shift_note.is_for_qc, is_for_shipping: @shift_note.is_for_shipping, note_on: @shift_note.note_on, notes: @shift_note.notes, shift: @shift_note.shift, user_id: @shift_note.user_id } }
    end

    assert_redirected_to shift_note_url(ShiftNote.last)
  end

  test "should show shift_note" do
    get shift_note_url(@shift_note)
    assert_response :success
  end

  test "should get edit" do
    get edit_shift_note_url(@shift_note)
    assert_response :success
  end

  test "should update shift_note" do
    patch shift_note_url(@shift_note), params: { shift_note: { department: @shift_note.department, discarded_at: @shift_note.discarded_at, is_for_it: @shift_note.is_for_it, is_for_lab: @shift_note.is_for_lab, is_for_maintenance: @shift_note.is_for_maintenance, is_for_plating: @shift_note.is_for_plating, is_for_qc: @shift_note.is_for_qc, is_for_shipping: @shift_note.is_for_shipping, note_on: @shift_note.note_on, notes: @shift_note.notes, shift: @shift_note.shift, user_id: @shift_note.user_id } }
    assert_redirected_to shift_note_url(@shift_note)
  end

  test "should destroy shift_note" do
    assert_difference('ShiftNote.count', -1) do
      delete shift_note_url(@shift_note)
    end

    assert_redirected_to shift_notes_url
  end
end
