class RemoveMacAddressFromNetworkHosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :network_hosts, :mac_address
  end
end
