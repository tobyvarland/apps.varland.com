require "test_helper"

class NetworkHostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @network_host = network_hosts(:one)
  end

  test "should get index" do
    get network_hosts_url
    assert_response :success
  end

  test "should get new" do
    get new_network_host_url
    assert_response :success
  end

  test "should create network_host" do
    assert_difference('NetworkHost.count') do
      post network_hosts_url, params: { network_host: { address: @network_host.address, device_type: @network_host.device_type, hostname: @network_host.hostname, mac_address: @network_host.mac_address, vlan_number: @network_host.vlan_number } }
    end

    assert_redirected_to network_host_url(NetworkHost.last)
  end

  test "should show network_host" do
    get network_host_url(@network_host)
    assert_response :success
  end

  test "should get edit" do
    get edit_network_host_url(@network_host)
    assert_response :success
  end

  test "should update network_host" do
    patch network_host_url(@network_host), params: { network_host: { address: @network_host.address, device_type: @network_host.device_type, hostname: @network_host.hostname, mac_address: @network_host.mac_address, vlan_number: @network_host.vlan_number } }
    assert_redirected_to network_host_url(@network_host)
  end

  test "should destroy network_host" do
    assert_difference('NetworkHost.count', -1) do
      delete network_host_url(@network_host)
    end

    assert_redirected_to network_hosts_url
  end
end
