require "test_helper"

class EmployeeNoteSubjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @employee_note_subject = employee_note_subjects(:one)
  end

  test "should get index" do
    get employee_note_subjects_url
    assert_response :success
  end

  test "should get new" do
    get new_employee_note_subject_url
    assert_response :success
  end

  test "should create employee_note_subject" do
    assert_difference('EmployeeNoteSubject.count') do
      post employee_note_subjects_url, params: { employee_note_subject: { employee_note_id: @employee_note_subject.employee_note_id, note_type: @employee_note_subject.note_type, user_id: @employee_note_subject.user_id } }
    end

    assert_redirected_to employee_note_subject_url(EmployeeNoteSubject.last)
  end

  test "should show employee_note_subject" do
    get employee_note_subject_url(@employee_note_subject)
    assert_response :success
  end

  test "should get edit" do
    get edit_employee_note_subject_url(@employee_note_subject)
    assert_response :success
  end

  test "should update employee_note_subject" do
    patch employee_note_subject_url(@employee_note_subject), params: { employee_note_subject: { employee_note_id: @employee_note_subject.employee_note_id, note_type: @employee_note_subject.note_type, user_id: @employee_note_subject.user_id } }
    assert_redirected_to employee_note_subject_url(@employee_note_subject)
  end

  test "should destroy employee_note_subject" do
    assert_difference('EmployeeNoteSubject.count', -1) do
      delete employee_note_subject_url(@employee_note_subject)
    end

    assert_redirected_to employee_note_subjects_url
  end
end
