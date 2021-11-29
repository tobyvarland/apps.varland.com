# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_11_29_194558) do

  create_table "active_storage_attachments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "as400_shop_orders", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "customer_code", limit: 6, null: false
    t.string "process_code", limit: 3, null: false
    t.string "part", limit: 17, null: false
    t.string "sub", limit: 1
    t.integer "number", null: false
    t.string "part_name", null: false
    t.string "process_spec", null: false
    t.string "part_description", null: false
    t.string "customer_name", null: false
    t.string "purchase_order"
    t.date "received_on", null: false
    t.date "written_up_on", null: false
    t.float "pounds", null: false
    t.integer "pieces", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "schedule_code", null: false
    t.integer "container_count", null: false
    t.string "container_type", null: false
    t.string "equipment_used"
    t.datetime "received_at"
    t.float "piece_weight", null: false
    t.boolean "printed_trico_labels", default: false, null: false
    t.string "slug"
    t.index ["number"], name: "unique_shop_order", unique: true
    t.index ["slug"], name: "index_as400_shop_orders_on_slug", unique: true
  end

  create_table "attachments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "attachable_type", null: false
    t.bigint "attachable_id", null: false
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["attachable_type", "attachable_id"], name: "index_attachments_on_attachable"
  end

  create_table "baking_containers", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "cycle_id", null: false
    t.bigint "load_id"
    t.integer "position", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cycle_id"], name: "index_baking_containers_on_cycle_id"
    t.index ["load_id"], name: "index_baking_containers_on_load_id"
  end

  create_table "baking_cycles", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "oven_type_id", null: false
    t.bigint "oven_id"
    t.bigint "stand_id", null: false
    t.bigint "user_id"
    t.bigint "procedure_id"
    t.string "container_type", null: false
    t.datetime "cycle_started_at"
    t.datetime "finished_loading_at"
    t.datetime "purge_ended_at"
    t.datetime "soak_started_at"
    t.datetime "soak_ended_at"
    t.datetime "gas_off_at"
    t.datetime "finished_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["oven_id"], name: "index_baking_cycles_on_oven_id"
    t.index ["oven_type_id"], name: "index_baking_cycles_on_oven_type_id"
    t.index ["procedure_id"], name: "index_baking_cycles_on_procedure_id"
    t.index ["stand_id"], name: "index_baking_cycles_on_stand_id"
    t.index ["user_id"], name: "index_baking_cycles_on_user_id"
  end

  create_table "baking_loads", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.integer "number", null: false
    t.boolean "is_rework", default: false, null: false
    t.boolean "is_on_bakestand", default: false, null: false
    t.datetime "in_oven_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_baking_loads_on_order_id"
  end

  create_table "baking_orders", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "cycle_id", null: false
    t.bigint "process_code_id"
    t.integer "number", null: false
    t.string "customer", null: false
    t.string "process", null: false
    t.string "part", null: false
    t.string "sub"
    t.string "operation_letter"
    t.integer "minimum"
    t.integer "maximum"
    t.integer "setpoint"
    t.integer "soak_length"
    t.string "profile_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cycle_id"], name: "index_baking_orders_on_cycle_id"
    t.index ["process_code_id"], name: "index_baking_orders_on_process_code_id"
  end

  create_table "baking_oven_types", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "description", null: false
    t.boolean "is_iao", default: false, null: false
    t.integer "max_trays", default: 0, null: false
    t.integer "max_rods", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "baking_ovens", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "oven_type_id", null: false
    t.string "description", null: false
    t.boolean "is_left_side", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["oven_type_id"], name: "index_baking_ovens_on_oven_type_id"
  end

  create_table "baking_procedures", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "description", null: false
    t.integer "minimum", null: false
    t.integer "maximum", null: false
    t.integer "setpoint", null: false
    t.integer "soak_length", null: false
    t.string "profile_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "baking_process_codes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "code"
    t.boolean "is_allowed_on_left_side"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "baking_stand_assignments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "oven_type_id", null: false
    t.bigint "stand_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["oven_type_id"], name: "index_baking_stand_assignments_on_oven_type_id"
    t.index ["stand_id"], name: "index_baking_stand_assignments_on_stand_id"
  end

  create_table "baking_stands", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "number", null: false
    t.string "stand_type", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "baking_status_readings", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "oven_id", null: false
    t.bigint "cycle_id"
    t.datetime "status_at", null: false
    t.float "air_temperature", null: false
    t.float "parts_temperature", null: false
    t.float "chamber_pressure"
    t.boolean "is_purging"
    t.boolean "is_cooling"
    t.boolean "is_gas_flowing"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cycle_id"], name: "index_baking_status_readings_on_cycle_id"
    t.index ["oven_id"], name: "index_baking_status_readings_on_oven_id"
  end

  create_table "baking_type_assignments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "oven_type_id", null: false
    t.bigint "process_code_id", null: false
    t.integer "max_temperature", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["oven_type_id"], name: "index_baking_type_assignments_on_oven_type_id"
    t.index ["process_code_id"], name: "index_baking_type_assignments_on_process_code_id"
  end

  create_table "comments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "commentable_type", null: false
    t.bigint "commentable_id", null: false
    t.text "body", null: false
    t.datetime "comment_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "discarded_at"
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "employee_note_subjects", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "employee_note_id", null: false
    t.string "note_type", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employee_note_id"], name: "index_employee_note_subjects_on_employee_note_id"
    t.index ["user_id"], name: "index_employee_note_subjects_on_user_id"
  end

  create_table "employee_notes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "note_on", null: false
    t.text "notes", null: false
    t.datetime "discarded_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["discarded_at"], name: "index_employee_notes_on_discarded_at"
    t.index ["user_id"], name: "index_employee_notes_on_user_id"
  end

  create_table "groov_logs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "type", null: false
    t.string "controller_name", null: false
    t.datetime "log_at", null: false
    t.integer "lane"
    t.integer "station"
    t.bigint "shop_order_id"
    t.integer "load"
    t.integer "barrel"
    t.float "reading"
    t.float "limit"
    t.float "low_limit"
    t.float "high_limit"
    t.string "device"
    t.text "json_data", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "discarded_at"
    t.bigint "user_id"
    t.index ["discarded_at"], name: "index_groov_logs_on_discarded_at"
    t.index ["shop_order_id"], name: "index_groov_logs_on_shop_order_id"
    t.index ["user_id"], name: "index_groov_logs_on_user_id"
  end

  create_table "opto_logs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "type", null: false
    t.string "controller_name", null: false
    t.datetime "log_at", null: false
    t.integer "lane"
    t.integer "station"
    t.integer "shop_order"
    t.integer "load"
    t.integer "barrel"
    t.string "customer"
    t.string "process"
    t.string "part"
    t.string "sub"
    t.float "reading"
    t.float "limit"
    t.float "low_limit"
    t.float "high_limit"
    t.text "json_data", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "permissions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.boolean "super_admin", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "reject_tags", default: 1, null: false
    t.integer "hardness_tests", default: 1, null: false
    t.integer "shift_notes", default: 0, null: false
    t.integer "employee_notes", default: 0, null: false
    t.integer "final_inspection", default: 0, null: false
    t.integer "calibrations", default: 0, null: false
    t.index ["user_id"], name: "index_permissions_on_user_id"
    t.index ["user_id"], name: "unique_permissions_user", unique: true
  end

  create_table "quality_calibration_categories", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.integer "calibration_frequency"
    t.string "instructions_url"
    t.float "two_point_low_value"
    t.float "two_point_high_value"
    t.datetime "discarded_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "calibration_method", null: false
    t.string "rockwell_scale"
    t.float "test_block_hardness"
    t.string "test_block_serial"
    t.float "maximum_error"
    t.float "maximum_repeatability"
    t.index ["discarded_at"], name: "index_quality_calibration_categories_on_discarded_at"
  end

  create_table "quality_calibration_devices", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.string "name", null: false
    t.string "location"
    t.date "in_service_on", null: false
    t.date "retired_on"
    t.datetime "discarded_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "results_updated_at"
    t.date "last_calibrated_on"
    t.date "next_calibration_due_on"
    t.string "calibration_due_status", null: false
    t.index ["category_id"], name: "index_quality_calibration_devices_on_category_id"
    t.index ["discarded_at"], name: "index_quality_calibration_devices_on_discarded_at"
  end

  create_table "quality_calibration_reason_codes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "discarded_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["discarded_at"], name: "index_quality_calibration_reason_codes_on_discarded_at"
  end

  create_table "quality_calibration_results", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "device_id", null: false
    t.bigint "user_id", null: false
    t.bigint "reason_code_id", null: false
    t.date "calibrated_on", null: false
    t.datetime "discarded_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "type", null: false
    t.float "two_point_low_value"
    t.float "two_point_low_reading"
    t.float "two_point_high_value"
    t.float "two_point_high_reading"
    t.float "two_point_offset"
    t.float "two_point_gain"
    t.float "reading_1"
    t.float "reading_2"
    t.float "test_block"
    t.string "rockwell_scale"
    t.string "test_block_serial"
    t.float "maximum_error"
    t.float "maximum_repeatability"
    t.index ["device_id"], name: "index_quality_calibration_results_on_device_id"
    t.index ["discarded_at"], name: "index_quality_calibration_results_on_discarded_at"
    t.index ["reason_code_id"], name: "index_quality_calibration_results_on_reason_code_id"
    t.index ["user_id"], name: "index_quality_calibration_results_on_user_id"
  end

  create_table "quality_hardness_tests", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "shop_order_id", null: false
    t.bigint "raw_test_id"
    t.date "tested_on", null: false
    t.integer "load"
    t.boolean "is_rework"
    t.string "test_type", null: false
    t.float "piece_1", null: false
    t.float "piece_2", null: false
    t.float "piece_3", null: false
    t.float "piece_4", null: false
    t.float "piece_5", null: false
    t.datetime "discarded_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "average"
    t.index ["discarded_at"], name: "index_quality_hardness_tests_on_discarded_at"
    t.index ["raw_test_id"], name: "index_quality_hardness_tests_on_raw_test_id"
    t.index ["shop_order_id"], name: "index_quality_hardness_tests_on_shop_order_id"
    t.index ["user_id"], name: "index_quality_hardness_tests_on_user_id"
  end

  create_table "quality_reject_tag_loads", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "reject_tag_id", null: false
    t.integer "number", null: false
    t.integer "barrel"
    t.integer "station"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["reject_tag_id"], name: "index_quality_reject_tag_loads_on_reject_tag_id"
  end

  create_table "quality_reject_tags", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "shop_order_id", null: false
    t.integer "number", null: false
    t.bigint "source_id"
    t.date "rejected_on", null: false
    t.bigint "user_id", null: false
    t.string "loads_rejected", null: false
    t.float "pounds", null: false
    t.integer "department", null: false
    t.string "defect", null: false
    t.text "defect_description"
    t.string "cause", null: false
    t.text "cause_description"
    t.boolean "print_partial_tag", default: false, null: false
    t.datetime "discarded_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.index ["shop_order_id"], name: "index_quality_reject_tags_on_shop_order_id"
    t.index ["slug"], name: "index_quality_reject_tags_on_slug", unique: true
    t.index ["source_id"], name: "index_quality_reject_tags_on_source_id"
    t.index ["user_id"], name: "index_quality_reject_tags_on_user_id"
  end

  create_table "quality_salt_spray_opto_post_dips", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "shop_order_id", null: false
    t.datetime "post_dip_at", null: false
    t.string "vat", null: false
    t.string "description"
    t.integer "load", null: false
    t.float "dip_seconds", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["shop_order_id"], name: "index_quality_salt_spray_opto_post_dips_on_shop_order_id"
  end

  create_table "reviews", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "reviewable_type", null: false
    t.bigint "reviewable_id", null: false
    t.datetime "completed_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["reviewable_type", "reviewable_id"], name: "index_reviews_on_reviewable"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "shift_notes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "note_on", null: false
    t.integer "shift", null: false
    t.integer "department"
    t.text "notes", null: false
    t.boolean "is_for_it", default: false, null: false
    t.boolean "is_for_lab", default: false, null: false
    t.boolean "is_for_maintenance", default: false, null: false
    t.boolean "is_for_plating", default: false, null: false
    t.boolean "is_for_qc", default: false, null: false
    t.boolean "is_for_shipping", default: false, null: false
    t.datetime "discarded_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["discarded_at"], name: "index_shift_notes_on_discarded_at"
    t.index ["user_id"], name: "index_shift_notes_on_user_id"
  end

  create_table "shipping_receiving_priority_notes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "request_type", null: false
    t.text "request_details", null: false
    t.bigint "requested_by_user_id", null: false
    t.bigint "completed_by_user_id"
    t.datetime "completed_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["completed_at"], name: "recnote_comp_user"
    t.index ["completed_by_user_id"], name: "recnote_req_user"
    t.index ["requested_by_user_id"], name: "index_shipping_receiving_priority_notes_on_requested_by_user_id"
  end

  create_table "shipping_trico_bins", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "shop_order_id", null: false
    t.datetime "load_at", null: false
    t.integer "load_number", null: false
    t.float "scale_weight", null: false
    t.float "percent_of_total"
    t.integer "proportional_pieces"
    t.integer "fudge_pieces"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["shop_order_id"], name: "index_shipping_trico_bins_on_shop_order_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", null: false
    t.string "name", null: false
    t.integer "employee_number", null: false
    t.string "title"
    t.string "uid"
    t.string "remember_token"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "discarded_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username", null: false
    t.boolean "is_active", default: true, null: false
    t.string "pin"
  end

  create_table "versions", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "item_type", limit: 191, null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object", size: :long
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "baking_containers", "baking_cycles", column: "cycle_id"
  add_foreign_key "baking_containers", "baking_loads", column: "load_id"
  add_foreign_key "baking_cycles", "baking_oven_types", column: "oven_type_id"
  add_foreign_key "baking_cycles", "baking_ovens", column: "oven_id"
  add_foreign_key "baking_cycles", "baking_procedures", column: "procedure_id"
  add_foreign_key "baking_cycles", "baking_stands", column: "stand_id"
  add_foreign_key "baking_cycles", "users"
  add_foreign_key "baking_loads", "baking_orders", column: "order_id"
  add_foreign_key "baking_orders", "baking_cycles", column: "cycle_id"
  add_foreign_key "baking_orders", "baking_process_codes", column: "process_code_id"
  add_foreign_key "baking_ovens", "baking_oven_types", column: "oven_type_id"
  add_foreign_key "baking_stand_assignments", "baking_oven_types", column: "oven_type_id"
  add_foreign_key "baking_stand_assignments", "baking_stands", column: "stand_id"
  add_foreign_key "baking_status_readings", "baking_cycles", column: "cycle_id"
  add_foreign_key "baking_status_readings", "baking_ovens", column: "oven_id"
  add_foreign_key "baking_type_assignments", "baking_oven_types", column: "oven_type_id"
  add_foreign_key "baking_type_assignments", "baking_process_codes", column: "process_code_id"
  add_foreign_key "comments", "users"
  add_foreign_key "employee_note_subjects", "employee_notes"
  add_foreign_key "employee_note_subjects", "users"
  add_foreign_key "employee_notes", "users"
  add_foreign_key "groov_logs", "as400_shop_orders", column: "shop_order_id"
  add_foreign_key "groov_logs", "users"
  add_foreign_key "permissions", "users"
  add_foreign_key "quality_calibration_devices", "quality_calibration_categories", column: "category_id"
  add_foreign_key "quality_calibration_results", "quality_calibration_devices", column: "device_id"
  add_foreign_key "quality_calibration_results", "quality_calibration_reason_codes", column: "reason_code_id"
  add_foreign_key "quality_calibration_results", "users"
  add_foreign_key "quality_hardness_tests", "as400_shop_orders", column: "shop_order_id"
  add_foreign_key "quality_hardness_tests", "quality_hardness_tests", column: "raw_test_id"
  add_foreign_key "quality_hardness_tests", "users"
  add_foreign_key "quality_reject_tag_loads", "quality_reject_tags", column: "reject_tag_id"
  add_foreign_key "quality_reject_tags", "as400_shop_orders", column: "shop_order_id"
  add_foreign_key "quality_reject_tags", "quality_reject_tags", column: "source_id"
  add_foreign_key "quality_reject_tags", "users"
  add_foreign_key "quality_salt_spray_opto_post_dips", "as400_shop_orders", column: "shop_order_id"
  add_foreign_key "reviews", "users"
  add_foreign_key "shift_notes", "users"
  add_foreign_key "shipping_receiving_priority_notes", "users", column: "completed_by_user_id", name: "fk_recnotes_comp_user"
  add_foreign_key "shipping_receiving_priority_notes", "users", column: "requested_by_user_id", name: "fk_recnotes_req_user"
  add_foreign_key "shipping_trico_bins", "as400_shop_orders", column: "shop_order_id"
end
