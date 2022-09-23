require "test_helper"

class Bake::StandardProceduresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bake_standard_procedure = bake_standard_procedures(:one)
  end

  test "should get index" do
    get bake_standard_procedures_url
    assert_response :success
  end

  test "should get new" do
    get new_bake_standard_procedure_url
    assert_response :success
  end

  test "should create bake_standard_procedure" do
    assert_difference('Bake::StandardProcedure.count') do
      post bake_standard_procedures_url, params: { bake_standard_procedure: { maximum: @bake_standard_procedure.maximum, minimum: @bake_standard_procedure.minimum, name: @bake_standard_procedure.name, process_codes: @bake_standard_procedure.process_codes, profile_name: @bake_standard_procedure.profile_name, setpoint: @bake_standard_procedure.setpoint, soak_hours: @bake_standard_procedure.soak_hours, within_hours: @bake_standard_procedure.within_hours } }
    end

    assert_redirected_to bake_standard_procedure_url(Bake::StandardProcedure.last)
  end

  test "should show bake_standard_procedure" do
    get bake_standard_procedure_url(@bake_standard_procedure)
    assert_response :success
  end

  test "should get edit" do
    get edit_bake_standard_procedure_url(@bake_standard_procedure)
    assert_response :success
  end

  test "should update bake_standard_procedure" do
    patch bake_standard_procedure_url(@bake_standard_procedure), params: { bake_standard_procedure: { maximum: @bake_standard_procedure.maximum, minimum: @bake_standard_procedure.minimum, name: @bake_standard_procedure.name, process_codes: @bake_standard_procedure.process_codes, profile_name: @bake_standard_procedure.profile_name, setpoint: @bake_standard_procedure.setpoint, soak_hours: @bake_standard_procedure.soak_hours, within_hours: @bake_standard_procedure.within_hours } }
    assert_redirected_to bake_standard_procedure_url(@bake_standard_procedure)
  end

  test "should destroy bake_standard_procedure" do
    assert_difference('Bake::StandardProcedure.count', -1) do
      delete bake_standard_procedure_url(@bake_standard_procedure)
    end

    assert_redirected_to bake_standard_procedures_url
  end
end
