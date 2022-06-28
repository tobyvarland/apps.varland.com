require "application_system_test_case"

class NetworkHostsTest < ApplicationSystemTestCase
  setup do
    @network_host = network_hosts(:one)
  end

  test "visiting the index" do
    visit network_hosts_url
    assert_selector "h1", text: "Network Hosts"
  end

  test "creating a Network host" do
    visit network_hosts_url
    click_on "New Network Host"

    fill_in "Address", with: @network_host.address
    fill_in "Device type", with: @network_host.device_type
    fill_in "Hostname", with: @network_host.hostname
    fill_in "Mac address", with: @network_host.mac_address
    fill_in "Vlan number", with: @network_host.vlan_number
    click_on "Create Network host"

    assert_text "Network host was successfully created"
    click_on "Back"
  end

  test "updating a Network host" do
    visit network_hosts_url
    click_on "Edit", match: :first

    fill_in "Address", with: @network_host.address
    fill_in "Device type", with: @network_host.device_type
    fill_in "Hostname", with: @network_host.hostname
    fill_in "Mac address", with: @network_host.mac_address
    fill_in "Vlan number", with: @network_host.vlan_number
    click_on "Update Network host"

    assert_text "Network host was successfully updated"
    click_on "Back"
  end

  test "destroying a Network host" do
    visit network_hosts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Network host was successfully destroyed"
  end
end
