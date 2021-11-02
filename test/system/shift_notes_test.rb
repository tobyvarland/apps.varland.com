require "application_system_test_case"

class ShiftNotesTest < ApplicationSystemTestCase
  setup do
    @shift_note = shift_notes(:one)
  end

  test "visiting the index" do
    visit shift_notes_url
    assert_selector "h1", text: "Shift Notes"
  end

  test "creating a Shift note" do
    visit shift_notes_url
    click_on "New Shift Note"

    fill_in "Department", with: @shift_note.department
    fill_in "Discarded at", with: @shift_note.discarded_at
    check "Is for it" if @shift_note.is_for_it
    check "Is for lab" if @shift_note.is_for_lab
    check "Is for maintenance" if @shift_note.is_for_maintenance
    check "Is for plating" if @shift_note.is_for_plating
    check "Is for qc" if @shift_note.is_for_qc
    check "Is for shipping" if @shift_note.is_for_shipping
    fill_in "Note on", with: @shift_note.note_on
    fill_in "Notes", with: @shift_note.notes
    fill_in "Shift", with: @shift_note.shift
    fill_in "User", with: @shift_note.user_id
    click_on "Create Shift note"

    assert_text "Shift note was successfully created"
    click_on "Back"
  end

  test "updating a Shift note" do
    visit shift_notes_url
    click_on "Edit", match: :first

    fill_in "Department", with: @shift_note.department
    fill_in "Discarded at", with: @shift_note.discarded_at
    check "Is for it" if @shift_note.is_for_it
    check "Is for lab" if @shift_note.is_for_lab
    check "Is for maintenance" if @shift_note.is_for_maintenance
    check "Is for plating" if @shift_note.is_for_plating
    check "Is for qc" if @shift_note.is_for_qc
    check "Is for shipping" if @shift_note.is_for_shipping
    fill_in "Note on", with: @shift_note.note_on
    fill_in "Notes", with: @shift_note.notes
    fill_in "Shift", with: @shift_note.shift
    fill_in "User", with: @shift_note.user_id
    click_on "Update Shift note"

    assert_text "Shift note was successfully updated"
    click_on "Back"
  end

  test "destroying a Shift note" do
    visit shift_notes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Shift note was successfully destroyed"
  end
end
