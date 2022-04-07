require "application_system_test_case"

class Groov::Baking::CyclesTest < ApplicationSystemTestCase
  setup do
    @groov_baking_cycle = groov_baking_cycles(:one)
  end

  test "visiting the index" do
    visit groov_baking_cycles_url
    assert_selector "h1", text: "Groov/Baking/Cycles"
  end

  test "creating a Cycle" do
    visit groov_baking_cycles_url
    click_on "New Groov/Baking/Cycle"

    fill_in "Bake type", with: @groov_baking_cycle.bake_type
    fill_in "Cycle ended at", with: @groov_baking_cycle.cycle_ended_at
    fill_in "Cycle started at", with: @groov_baking_cycle.cycle_started_at
    fill_in "Gas off at", with: @groov_baking_cycle.gas_off_at
    fill_in "Maximum", with: @groov_baking_cycle.maximum
    fill_in "Minimum", with: @groov_baking_cycle.minimum
    fill_in "Oven", with: @groov_baking_cycle.oven
    fill_in "Profile name", with: @groov_baking_cycle.profile_name
    fill_in "Purge ended at", with: @groov_baking_cycle.purge_ended_at
    fill_in "Setpoint", with: @groov_baking_cycle.setpoint
    fill_in "Soak ended at", with: @groov_baking_cycle.soak_ended_at
    fill_in "Soak length", with: @groov_baking_cycle.soak_length
    fill_in "Soak started at", with: @groov_baking_cycle.soak_started_at
    click_on "Create Cycle"

    assert_text "Cycle was successfully created"
    click_on "Back"
  end

  test "updating a Cycle" do
    visit groov_baking_cycles_url
    click_on "Edit", match: :first

    fill_in "Bake type", with: @groov_baking_cycle.bake_type
    fill_in "Cycle ended at", with: @groov_baking_cycle.cycle_ended_at
    fill_in "Cycle started at", with: @groov_baking_cycle.cycle_started_at
    fill_in "Gas off at", with: @groov_baking_cycle.gas_off_at
    fill_in "Maximum", with: @groov_baking_cycle.maximum
    fill_in "Minimum", with: @groov_baking_cycle.minimum
    fill_in "Oven", with: @groov_baking_cycle.oven
    fill_in "Profile name", with: @groov_baking_cycle.profile_name
    fill_in "Purge ended at", with: @groov_baking_cycle.purge_ended_at
    fill_in "Setpoint", with: @groov_baking_cycle.setpoint
    fill_in "Soak ended at", with: @groov_baking_cycle.soak_ended_at
    fill_in "Soak length", with: @groov_baking_cycle.soak_length
    fill_in "Soak started at", with: @groov_baking_cycle.soak_started_at
    click_on "Update Cycle"

    assert_text "Cycle was successfully updated"
    click_on "Back"
  end

  test "destroying a Cycle" do
    visit groov_baking_cycles_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Cycle was successfully destroyed"
  end
end
