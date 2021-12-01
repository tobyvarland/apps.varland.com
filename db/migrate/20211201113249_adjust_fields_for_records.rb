class AdjustFieldsForRecords < ActiveRecord::Migration[6.1]
  def change

    remove_column :records_reason_codes,  :require_comment
    remove_column :records_record_types,  :is_internal

    add_column    :records_results, :is_valid, :boolean, null: true

    add_column    :records_results, :reading_average, :float, null: true
    add_column    :records_results, :reading_error, :float, null: true
    add_column    :records_results, :reading_repeatability, :float, null: true
    add_column    :records_results, :reading_error_valid, :boolean, null: true
    add_column    :records_results, :reading_repeatability_valid, :boolean, null: true

    add_column    :records_results, :collection_1_rate, :float, null: true
    add_column    :records_results, :collection_1_rate_valid, :boolean, null: true
    add_column    :records_results, :collection_2_rate, :float, null: true
    add_column    :records_results, :collection_2_rate_valid, :boolean, null: true

  end
end