require "application_system_test_case"

class EmployeeNotesTest < ApplicationSystemTestCase
  setup do
    @employee_note = employee_notes(:one)
  end

  test "visiting the index" do
    visit employee_notes_url
    assert_selector "h1", text: "Employee Notes"
  end

  test "creating a Employee note" do
    visit employee_notes_url
    click_on "New Employee Note"

    fill_in "Discared at", with: @employee_note.discarded_at
    fill_in "Note on", with: @employee_note.note_on
    fill_in "Notes", with: @employee_note.notes
    fill_in "User", with: @employee_note.user_id
    click_on "Create Employee note"

    assert_text "Employee note was successfully created"
    click_on "Back"
  end

  test "updating a Employee note" do
    visit employee_notes_url
    click_on "Edit", match: :first

    fill_in "Discared at", with: @employee_note.discarded_at
    fill_in "Note on", with: @employee_note.note_on
    fill_in "Notes", with: @employee_note.notes
    fill_in "User", with: @employee_note.user_id
    click_on "Update Employee note"

    assert_text "Employee note was successfully updated"
    click_on "Back"
  end

  test "destroying a Employee note" do
    visit employee_notes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Employee note was successfully destroyed"
  end
end
