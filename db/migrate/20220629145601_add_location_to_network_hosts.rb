class AddLocationToNetworkHosts < ActiveRecord::Migration[6.1]
  def change
    add_column  :network_hosts, :location,  :string,  null: false
  end
end