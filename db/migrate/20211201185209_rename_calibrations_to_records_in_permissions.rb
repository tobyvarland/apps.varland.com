class RenameCalibrationsToRecordsInPermissions < ActiveRecord::Migration[6.1]
  def change
    rename_column :permissions, :calibrations, :records
  end
end