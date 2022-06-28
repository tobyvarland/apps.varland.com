class RemoveDeviceTypeFromNetworkHosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :network_hosts, :device_type
  end
end