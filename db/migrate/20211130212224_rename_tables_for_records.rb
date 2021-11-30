class RenameTablesForRecords < ActiveRecord::Migration[6.1]
  def change
    rename_column :calibrations_assignments, :calibration_type_id, :record_type_id
    rename_column :calibrations_results, :calibration_type_id, :record_type_id
    rename_table :calibrations_assignments, :records_assignments
    rename_table :calibrations_calibration_types, :records_record_types
    rename_table :calibrations_devices, :records_devices
    rename_table :calibrations_reason_codes, :records_reason_codes
    rename_table :calibrations_results, :records_results
  end
end