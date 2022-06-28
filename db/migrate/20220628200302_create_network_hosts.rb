class CreateNetworkHosts < ActiveRecord::Migration[6.1]
  def change
    create_table :network_hosts do |t|
      t.string      :hostname,      null: false,  unique: true
      t.integer     :vlan_number,   null: false
      t.integer     :address,       null: false
      t.string      :mac_address,   null: false,  unique: true
      t.string      :device_type,   null: false
      t.timestamps
      t.datetime    :discarded_at,  null: true,   index: true
    end
  end
end