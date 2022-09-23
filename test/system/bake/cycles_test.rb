require "application_system_test_case"

class Bake::CyclesTest < ApplicationSystemTestCase
  setup do
    @bake_cycle = bake_cycles(:one)
  end

  test "visiting the index" do
    visit bake_cycles_url
    assert_selector "h1", text: "Bake/Cycles"
  end

  test "creating a Cycle" do
    visit bake_cycles_url
    click_on "New Bake/Cycle"

    fill_in "Cooling finished at", with: @bake_cycle.cooling_finished_at
    fill_in "Cycle ended at", with: @bake_cycle.cycle_ended_at
    fill_in "Cycle started at", with: @bake_cycle.cycle_started_at
    fill_in "Gas off at", with: @bake_cycle.gas_off_at
    check "Is locked" if @bake_cycle.is_locked
    fill_in "Loadings finished at", with: @bake_cycle.loadings_finished_at
    fill_in "Oven", with: @bake_cycle.oven
    fill_in "Psi consumed", with: @bake_cycle.psi_consumed
    fill_in "Purge finished at", with: @bake_cycle.purge_finished_at
    fill_in "Side", with: @bake_cycle.side
    fill_in "Soak ended at", with: @bake_cycle.soak_ended_at
    fill_in "Soak started at", with: @bake_cycle.soak_started_at
    fill_in "Type", with: @bake_cycle.type
    check "Used cooling profile" if @bake_cycle.used_cooling_profile
    fill_in "User", with: @bake_cycle.user_id
    click_on "Create Cycle"

    assert_text "Cycle was successfully created"
    click_on "Back"
  end

  test "updating a Cycle" do
    visit bake_cycles_url
    click_on "Edit", match: :first

    fill_in "Cooling finished at", with: @bake_cycle.cooling_finished_at
    fill_in "Cycle ended at", with: @bake_cycle.cycle_ended_at
    fill_in "Cycle started at", with: @bake_cycle.cycle_started_at
    fill_in "Gas off at", with: @bake_cycle.gas_off_at
    check "Is locked" if @bake_cycle.is_locked
    fill_in "Loadings finished at", with: @bake_cycle.loadings_finished_at
    fill_in "Oven", with: @bake_cycle.oven
    fill_in "Psi consumed", with: @bake_cycle.psi_consumed
    fill_in "Purge finished at", with: @bake_cycle.purge_finished_at
    fill_in "Side", with: @bake_cycle.side
    fill_in "Soak ended at", with: @bake_cycle.soak_ended_at
    fill_in "Soak started at", with: @bake_cycle.soak_started_at
    fill_in "Type", with: @bake_cycle.type
    check "Used cooling profile" if @bake_cycle.used_cooling_profile
    fill_in "User", with: @bake_cycle.user_id
    click_on "Update Cycle"

    assert_text "Cycle was successfully updated"
    click_on "Back"
  end

  test "destroying a Cycle" do
    visit bake_cycles_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Cycle was successfully destroyed"
  end
end
