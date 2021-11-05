require "application_system_test_case"

class EmployeeNoteSubjectsTest < ApplicationSystemTestCase
  setup do
    @employee_note_subject = employee_note_subjects(:one)
  end

  test "visiting the index" do
    visit employee_note_subjects_url
    assert_selector "h1", text: "Employee Note Subjects"
  end

  test "creating a Employee note subject" do
    visit employee_note_subjects_url
    click_on "New Employee Note Subject"

    fill_in "Employee note", with: @employee_note_subject.employee_note_id
    fill_in "Note type", with: @employee_note_subject.note_type
    fill_in "User", with: @employee_note_subject.user_id
    click_on "Create Employee note subject"

    assert_text "Employee note subject was successfully created"
    click_on "Back"
  end

  test "updating a Employee note subject" do
    visit employee_note_subjects_url
    click_on "Edit", match: :first

    fill_in "Employee note", with: @employee_note_subject.employee_note_id
    fill_in "Note type", with: @employee_note_subject.note_type
    fill_in "User", with: @employee_note_subject.user_id
    click_on "Update Employee note subject"

    assert_text "Employee note subject was successfully updated"
    click_on "Back"
  end

  test "destroying a Employee note subject" do
    visit employee_note_subjects_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Employee note subject was successfully destroyed"
  end
end
