require "application_system_test_case"

class Bake::StandardProceduresTest < ApplicationSystemTestCase
  setup do
    @bake_standard_procedure = bake_standard_procedures(:one)
  end

  test "visiting the index" do
    visit bake_standard_procedures_url
    assert_selector "h1", text: "Bake/Standard Procedures"
  end

  test "creating a Standard procedure" do
    visit bake_standard_procedures_url
    click_on "New Bake/Standard Procedure"

    fill_in "Maximum", with: @bake_standard_procedure.maximum
    fill_in "Minimum", with: @bake_standard_procedure.minimum
    fill_in "Name", with: @bake_standard_procedure.name
    fill_in "Process codes", with: @bake_standard_procedure.process_codes
    fill_in "Profile name", with: @bake_standard_procedure.profile_name
    fill_in "Setpoint", with: @bake_standard_procedure.setpoint
    fill_in "Soak hours", with: @bake_standard_procedure.soak_hours
    fill_in "Within hours", with: @bake_standard_procedure.within_hours
    click_on "Create Standard procedure"

    assert_text "Standard procedure was successfully created"
    click_on "Back"
  end

  test "updating a Standard procedure" do
    visit bake_standard_procedures_url
    click_on "Edit", match: :first

    fill_in "Maximum", with: @bake_standard_procedure.maximum
    fill_in "Minimum", with: @bake_standard_procedure.minimum
    fill_in "Name", with: @bake_standard_procedure.name
    fill_in "Process codes", with: @bake_standard_procedure.process_codes
    fill_in "Profile name", with: @bake_standard_procedure.profile_name
    fill_in "Setpoint", with: @bake_standard_procedure.setpoint
    fill_in "Soak hours", with: @bake_standard_procedure.soak_hours
    fill_in "Within hours", with: @bake_standard_procedure.within_hours
    click_on "Update Standard procedure"

    assert_text "Standard procedure was successfully updated"
    click_on "Back"
  end

  test "destroying a Standard procedure" do
    visit bake_standard_procedures_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Standard procedure was successfully destroyed"
  end
end
