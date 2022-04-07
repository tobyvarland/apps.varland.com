require "application_system_test_case"

class Groov::Bake::CyclesTest < ApplicationSystemTestCase
  setup do
    @groov_bake_cycle = groov_bake_cycles(:one)
  end

  test "visiting the index" do
    visit groov_bake_cycles_url
    assert_selector "h1", text: "Groov/Bake/Cycles"
  end

  test "creating a Cycle" do
    visit groov_bake_cycles_url
    click_on "New Groov/Bake/Cycle"

    fill_in "Bake profile", with: @groov_bake_cycle.bake_profile
    fill_in "Bakestand number", with: @groov_bake_cycle.bakestand_number
    fill_in "Cycle ended at", with: @groov_bake_cycle.cycle_ended_at
    fill_in "Cycle started at", with: @groov_bake_cycle.cycle_started_at
    fill_in "Discarded at", with: @groov_bake_cycle.discarded_at
    fill_in "Gas off at", with: @groov_bake_cycle.gas_off_at
    fill_in "Loading finished at", with: @groov_bake_cycle.loading_finished_at
    fill_in "Maximum", with: @groov_bake_cycle.maximum
    fill_in "Minimum", with: @groov_bake_cycle.minimum
    fill_in "Oven", with: @groov_bake_cycle.oven
    fill_in "Oven type", with: @groov_bake_cycle.oven_type
    fill_in "Purge ended at", with: @groov_bake_cycle.purge_ended_at
    fill_in "Rod cart number", with: @groov_bake_cycle.rod_cart_number
    fill_in "Setpoint", with: @groov_bake_cycle.setpoint
    fill_in "Side", with: @groov_bake_cycle.side
    fill_in "Soak ended at", with: @groov_bake_cycle.soak_ended_at
    fill_in "Soak length", with: @groov_bake_cycle.soak_length
    fill_in "Soak started at", with: @groov_bake_cycle.soak_started_at
    click_on "Create Cycle"

    assert_text "Cycle was successfully created"
    click_on "Back"
  end

  test "updating a Cycle" do
    visit groov_bake_cycles_url
    click_on "Edit", match: :first

    fill_in "Bake profile", with: @groov_bake_cycle.bake_profile
    fill_in "Bakestand number", with: @groov_bake_cycle.bakestand_number
    fill_in "Cycle ended at", with: @groov_bake_cycle.cycle_ended_at
    fill_in "Cycle started at", with: @groov_bake_cycle.cycle_started_at
    fill_in "Discarded at", with: @groov_bake_cycle.discarded_at
    fill_in "Gas off at", with: @groov_bake_cycle.gas_off_at
    fill_in "Loading finished at", with: @groov_bake_cycle.loading_finished_at
    fill_in "Maximum", with: @groov_bake_cycle.maximum
    fill_in "Minimum", with: @groov_bake_cycle.minimum
    fill_in "Oven", with: @groov_bake_cycle.oven
    fill_in "Oven type", with: @groov_bake_cycle.oven_type
    fill_in "Purge ended at", with: @groov_bake_cycle.purge_ended_at
    fill_in "Rod cart number", with: @groov_bake_cycle.rod_cart_number
    fill_in "Setpoint", with: @groov_bake_cycle.setpoint
    fill_in "Side", with: @groov_bake_cycle.side
    fill_in "Soak ended at", with: @groov_bake_cycle.soak_ended_at
    fill_in "Soak length", with: @groov_bake_cycle.soak_length
    fill_in "Soak started at", with: @groov_bake_cycle.soak_started_at
    click_on "Update Cycle"

    assert_text "Cycle was successfully updated"
    click_on "Back"
  end

  test "destroying a Cycle" do
    visit groov_bake_cycles_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Cycle was successfully destroyed"
  end
end
