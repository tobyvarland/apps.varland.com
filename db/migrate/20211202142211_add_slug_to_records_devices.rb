class AddSlugToRecordsDevices < ActiveRecord::Migration[6.1]
  def change
    add_column :records_devices, :slug, :string
    add_index :records_devices, :slug, unique: true
  end
end