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

ActiveRecord::Schema.define(version: 2023_02_07_192709) do

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
    t.string "iao_profile"
    t.integer "iao_setpoint"
    t.integer "iao_minimum"
    t.integer "iao_maximum"
    t.integer "iao_soak_length"
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

  create_table "bake_containers", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "stand_id", null: false
    t.integer "number", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["stand_id", "number"], name: "unique_number_on_stand", unique: true
    t.index ["stand_id"], name: "index_bake_containers_on_stand_id"
  end

  create_table "bake_cycles", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "type", null: false
    t.string "oven"
    t.string "side"
    t.boolean "is_locked", default: false, null: false
    t.datetime "cycle_started_at"
    t.datetime "loadings_finished_at"
    t.datetime "purge_finished_at"
    t.datetime "soak_started_at"
    t.datetime "soak_ended_at"
    t.datetime "gas_off_at"
    t.datetime "cooling_finished_at"
    t.datetime "cycle_ended_at"
    t.string "profile_name"
    t.float "psi_consumed"
    t.boolean "used_cooling_profile"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_bake_cycles_on_user_id"
  end

  create_table "bake_loadings", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "container_id", null: false
    t.bigint "load_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["container_id"], name: "index_bake_loadings_on_container_id"
    t.index ["load_id"], name: "index_bake_loadings_on_load_id"
  end

  create_table "bake_loads", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "shop_order_id", null: false
    t.integer "number", null: false
    t.boolean "not_loaded", default: false, null: false
    t.datetime "started_baking_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["shop_order_id", "number"], name: "unique_load_on_order", unique: true
    t.index ["shop_order_id"], name: "index_bake_loads_on_shop_order_id"
  end

  create_table "bake_shop_orders", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "cycle_id", null: false
    t.integer "number", null: false
    t.string "customer", null: false
    t.string "process", null: false
    t.string "part", null: false
    t.string "sub"
    t.string "operation", null: false
    t.integer "setpoint", null: false
    t.integer "minimum", null: false
    t.integer "maximum", null: false
    t.float "soak_hours", null: false
    t.float "within_hours"
    t.string "profile_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cycle_id", "number"], name: "unique_order_on_cycle", unique: true
    t.index ["cycle_id"], name: "index_bake_shop_orders_on_cycle_id"
  end

  create_table "bake_standard_procedures", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "process_codes"
    t.integer "setpoint", null: false
    t.integer "minimum", null: false
    t.integer "maximum", null: false
    t.float "soak_hours", null: false
    t.float "within_hours"
    t.string "profile_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_bake_standard_procedures_on_name", unique: true
  end

  create_table "bake_stands", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "cycle_id", null: false
    t.string "type", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cycle_id"], name: "index_bake_stands_on_cycle_id"
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

  create_table "groov_bake_containers", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "load_id", null: false
    t.string "description", null: false
    t.integer "bakestand_column"
    t.integer "bakestand_row"
    t.integer "rod_cart_shelf"
    t.integer "rod_cart_position"
    t.integer "oven_shelf"
    t.integer "oven_shelf_tray_position"
    t.integer "oven_shelf_rod_position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["load_id"], name: "index_groov_bake_containers_on_load_id"
  end

  create_table "groov_bake_cycles", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "oven_type", null: false
    t.bigint "user_id"
    t.string "oven"
    t.string "side"
    t.datetime "cycle_started_at"
    t.datetime "loading_finished_at"
    t.datetime "purge_ended_at"
    t.datetime "soak_started_at"
    t.datetime "soak_ended_at"
    t.datetime "gas_off_at"
    t.datetime "cycle_ended_at"
    t.string "bake_profile"
    t.integer "setpoint"
    t.integer "minimum"
    t.integer "maximum"
    t.integer "soak_length"
    t.integer "bakestand_number"
    t.integer "rod_cart_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "discarded_at"
    t.index ["user_id"], name: "index_groov_bake_cycles_on_user_id"
  end

  create_table "groov_bake_loads", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "shop_order_id", null: false
    t.integer "number", null: false
    t.boolean "is_rework", default: false, null: false
    t.boolean "is_on_bakestand", default: true, null: false
    t.datetime "in_oven_at"
    t.integer "container_count", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["shop_order_id"], name: "index_groov_bake_loads_on_shop_order_id"
  end

  create_table "groov_bake_plated_loads", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "load_id"
    t.bigint "as400_shop_order_id", null: false
    t.integer "number", null: false
    t.integer "department", null: false
    t.datetime "out_of_plating_at", null: false
    t.integer "bake_within", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["as400_shop_order_id"], name: "index_groov_bake_plated_loads_on_as400_shop_order_id"
    t.index ["load_id"], name: "index_groov_bake_plated_loads_on_load_id"
  end

  create_table "groov_bake_shop_orders", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "cycle_id", null: false
    t.bigint "as400_shop_order_id", null: false
    t.integer "container_type", null: false
    t.string "operation_letter", null: false
    t.string "bake_profile"
    t.integer "setpoint", null: false
    t.integer "minimum", null: false
    t.integer "maximum", null: false
    t.integer "soak_length", null: false
    t.integer "bake_within", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["as400_shop_order_id"], name: "index_groov_bake_shop_orders_on_as400_shop_order_id"
    t.index ["cycle_id"], name: "index_groov_bake_shop_orders_on_cycle_id"
  end

  create_table "groov_baking_cycles", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "bake_type", null: false
    t.string "oven"
    t.datetime "cycle_started_at"
    t.datetime "purge_ended_at"
    t.datetime "soak_started_at"
    t.datetime "soak_ended_at"
    t.datetime "gas_off_at"
    t.datetime "cycle_ended_at"
    t.integer "setpoint"
    t.integer "minimum"
    t.integer "maximum"
    t.integer "soak_length"
    t.string "profile_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "discarded_at"
  end

  create_table "groov_baking_loads", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "shop_order_id", null: false
    t.integer "number", null: false
    t.boolean "is_rework", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["shop_order_id"], name: "index_groov_baking_loads_on_shop_order_id"
  end

  create_table "groov_baking_shop_orders", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "cycle_id", null: false
    t.bigint "shop_order_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cycle_id"], name: "index_groov_baking_shop_orders_on_cycle_id"
    t.index ["shop_order_id"], name: "index_groov_baking_shop_orders_on_shop_order_id"
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
    t.text "description"
    t.index ["discarded_at"], name: "index_groov_logs_on_discarded_at"
    t.index ["shop_order_id"], name: "index_groov_logs_on_shop_order_id"
    t.index ["user_id"], name: "index_groov_logs_on_user_id"
  end

  create_table "hosts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "hostname", null: false
    t.integer "vlan_number", null: false
    t.integer "address", null: false
    t.string "mac_address", null: false
    t.string "device_type", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_hosts_on_discarded_at"
  end

  create_table "it_opto_strategies", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "network_hosts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "hostname", null: false
    t.integer "vlan_number", null: false
    t.integer "address", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "discarded_at"
    t.string "location", null: false
    t.index ["discarded_at"], name: "index_network_hosts_on_discarded_at"
  end

  create_table "notifications", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "text", null: false
    t.boolean "is_read", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
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
    t.integer "records", default: 0, null: false
    t.index ["user_id"], name: "index_permissions_on_user_id"
    t.index ["user_id"], name: "unique_permissions_user", unique: true
  end

  create_table "projects_assignments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "item_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_id"], name: "index_projects_assignments_on_item_id"
    t.index ["user_id"], name: "index_projects_assignments_on_user_id"
  end

  create_table "projects_categories", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "system_id", null: false
    t.string "name", null: false
    t.string "abbreviation", null: false
    t.integer "last_number_used", null: false
    t.string "comment_sections", null: false
    t.boolean "use_priorities", null: false
    t.boolean "use_tasks", null: false
    t.boolean "use_time_tracking", null: false
    t.boolean "use_reviews", null: false
    t.boolean "use_percent_complete", null: false
    t.boolean "allow_children", null: false
    t.boolean "allow_requests", null: false
    t.boolean "send_feedback", null: false
    t.boolean "use_due_date", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "discarded_at"
    t.string "source_options"
    t.text "designation_options"
    t.index ["system_id"], name: "index_projects_categories_on_system_id"
  end

  create_table "projects_items", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.integer "number"
    t.column "status", "enum('requested','opened','close_requested','closed','deleted','reopened','held')"
    t.integer "percent_complete"
    t.integer "priority"
    t.date "due_on"
    t.float "projected_hours"
    t.text "description", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "discarded_at"
    t.string "source"
    t.string "designation"
    t.index ["category_id"], name: "index_projects_items_on_category_id"
  end

  create_table "projects_status_updates", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "item_id", null: false
    t.column "status", "enum('requested','opened','close_requested','closed','deleted','reopened','held')"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_id"], name: "index_projects_status_updates_on_item_id"
    t.index ["user_id"], name: "index_projects_status_updates_on_user_id"
  end

  create_table "projects_systems", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "abbreviation", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "discarded_at"
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
    t.string "oven_type"
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
    t.string "reason"
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

  create_table "records_assignments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "device_id", null: false
    t.bigint "record_type_id", null: false
    t.datetime "results_updated_at"
    t.date "last_result_on"
    t.date "next_result_due_on"
    t.integer "next_result_due_in_days"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "discarded_at"
    t.index ["device_id"], name: "index_records_assignments_on_device_id"
    t.index ["discarded_at"], name: "index_records_assignments_on_discarded_at"
    t.index ["record_type_id"], name: "index_records_assignments_on_record_type_id"
  end

  create_table "records_devices", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "location"
    t.date "in_service_on", null: false
    t.date "retired_on"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "discarded_at"
    t.string "slug"
    t.index ["discarded_at"], name: "index_records_devices_on_discarded_at"
    t.index ["slug"], name: "index_records_devices_on_slug", unique: true
  end

  create_table "records_reason_codes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_records_reason_codes_on_discarded_at"
  end

  create_table "records_record_types", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.integer "frequency"
    t.string "url"
    t.string "record_subclass", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "discarded_at"
    t.float "expected_low"
    t.float "expected_high"
    t.string "rockwell_scale"
    t.float "test_block_hardness"
    t.string "test_block_serial"
    t.float "max_error"
    t.float "max_repeatability"
    t.string "data_type", null: false
    t.string "responsibility", null: false
    t.string "slug"
    t.text "instructions"
    t.index ["discarded_at"], name: "index_records_record_types_on_discarded_at"
    t.index ["slug"], name: "index_records_record_types_on_slug", unique: true
  end

  create_table "records_results", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "type"
    t.bigint "device_id", null: false
    t.bigint "record_type_id", null: false
    t.bigint "user_id", null: false
    t.bigint "reason_code_id", null: false
    t.date "result_on", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "discarded_at"
    t.float "expected_low"
    t.float "actual_low"
    t.float "expected_high"
    t.float "actual_high"
    t.float "offset"
    t.float "gain"
    t.string "rockwell_scale"
    t.float "test_block_hardness"
    t.string "test_block_serial"
    t.float "max_error"
    t.float "max_repeatability"
    t.float "reading_1"
    t.float "reading_2"
    t.float "temperature"
    t.float "collection_1_amount"
    t.float "collection_1_hours"
    t.float "collection_2_amount"
    t.float "collection_2_hours"
    t.boolean "is_valid"
    t.float "reading_average"
    t.float "reading_error"
    t.float "reading_repeatability"
    t.boolean "reading_error_valid"
    t.boolean "reading_repeatability_valid"
    t.float "collection_1_rate"
    t.boolean "collection_1_rate_valid"
    t.float "collection_2_rate"
    t.boolean "collection_2_rate_valid"
    t.float "salt_added"
    t.float "distilled_water_added"
    t.float "ph"
    t.float "weight"
    t.text "comments"
    t.boolean "reference"
    t.float "fwhm_number"
    t.index ["device_id"], name: "index_records_results_on_device_id"
    t.index ["discarded_at"], name: "index_records_results_on_discarded_at"
    t.index ["reason_code_id"], name: "index_records_results_on_reason_code_id"
    t.index ["record_type_id"], name: "index_records_results_on_record_type_id"
    t.index ["user_id"], name: "index_records_results_on_user_id"
  end

  create_table "records_xray_calibration_checks", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "result_id", null: false
    t.string "name", null: false
    t.string "action", null: false
    t.integer "position", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["result_id"], name: "index_records_xray_calibration_checks_on_result_id"
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

  create_table "scan_documents", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "scan_shop_orders", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "shop_order_id", null: false
    t.text "contents", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.index ["shop_order_id"], name: "index_scan_shop_orders_on_shop_order_id"
    t.index ["slug"], name: "index_scan_shop_orders_on_slug", unique: true
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

  create_table "training_videos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title", null: false
    t.text "description", null: false
    t.string "url", null: false
    t.string "slug", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "has_sound"
    t.index ["slug"], name: "index_training_videos_on_slug", unique: true
    t.index ["title"], name: "index_training_videos_on_title", unique: true
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
    t.bigint "payroll_account_id", default: 0, null: false
    t.datetime "clocked_in_at"
    t.boolean "is_foreman", default: false, null: false
    t.boolean "aux_foreman", default: false, null: false
    t.string "foreman_email_address"
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
  add_foreign_key "bake_containers", "bake_stands", column: "stand_id"
  add_foreign_key "bake_cycles", "users"
  add_foreign_key "bake_loadings", "bake_containers", column: "container_id"
  add_foreign_key "bake_loadings", "bake_loads", column: "load_id"
  add_foreign_key "bake_loads", "bake_shop_orders", column: "shop_order_id"
  add_foreign_key "bake_shop_orders", "bake_cycles", column: "cycle_id"
  add_foreign_key "bake_stands", "bake_cycles", column: "cycle_id"
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
  add_foreign_key "groov_bake_containers", "groov_bake_loads", column: "load_id"
  add_foreign_key "groov_bake_cycles", "users"
  add_foreign_key "groov_bake_loads", "groov_bake_shop_orders", column: "shop_order_id"
  add_foreign_key "groov_bake_plated_loads", "as400_shop_orders"
  add_foreign_key "groov_bake_plated_loads", "groov_bake_loads", column: "load_id"
  add_foreign_key "groov_bake_shop_orders", "as400_shop_orders"
  add_foreign_key "groov_bake_shop_orders", "groov_bake_cycles", column: "cycle_id"
  add_foreign_key "groov_baking_loads", "groov_baking_shop_orders", column: "shop_order_id"
  add_foreign_key "groov_baking_shop_orders", "as400_shop_orders", column: "shop_order_id"
  add_foreign_key "groov_baking_shop_orders", "groov_baking_cycles", column: "cycle_id"
  add_foreign_key "groov_logs", "as400_shop_orders", column: "shop_order_id"
  add_foreign_key "groov_logs", "users"
  add_foreign_key "notifications", "users"
  add_foreign_key "permissions", "users"
  add_foreign_key "projects_assignments", "projects_items", column: "item_id"
  add_foreign_key "projects_assignments", "users"
  add_foreign_key "projects_categories", "projects_systems", column: "system_id"
  add_foreign_key "projects_items", "projects_categories", column: "category_id"
  add_foreign_key "projects_status_updates", "projects_items", column: "item_id"
  add_foreign_key "projects_status_updates", "users"
  add_foreign_key "quality_hardness_tests", "as400_shop_orders", column: "shop_order_id"
  add_foreign_key "quality_hardness_tests", "quality_hardness_tests", column: "raw_test_id"
  add_foreign_key "quality_hardness_tests", "users"
  add_foreign_key "quality_reject_tag_loads", "quality_reject_tags", column: "reject_tag_id"
  add_foreign_key "quality_reject_tags", "as400_shop_orders", column: "shop_order_id"
  add_foreign_key "quality_reject_tags", "quality_reject_tags", column: "source_id"
  add_foreign_key "quality_reject_tags", "users"
  add_foreign_key "quality_salt_spray_opto_post_dips", "as400_shop_orders", column: "shop_order_id"
  add_foreign_key "records_assignments", "records_devices", column: "device_id"
  add_foreign_key "records_assignments", "records_record_types", column: "record_type_id"
  add_foreign_key "records_results", "records_devices", column: "device_id"
  add_foreign_key "records_results", "records_reason_codes", column: "reason_code_id"
  add_foreign_key "records_results", "records_record_types", column: "record_type_id"
  add_foreign_key "records_results", "users"
  add_foreign_key "records_xray_calibration_checks", "records_results", column: "result_id"
  add_foreign_key "reviews", "users"
  add_foreign_key "scan_shop_orders", "as400_shop_orders", column: "shop_order_id"
  add_foreign_key "shift_notes", "users"
  add_foreign_key "shipping_receiving_priority_notes", "users", column: "completed_by_user_id", name: "fk_recnotes_comp_user"
  add_foreign_key "shipping_receiving_priority_notes", "users", column: "requested_by_user_id", name: "fk_recnotes_req_user"
  add_foreign_key "shipping_trico_bins", "as400_shop_orders", column: "shop_order_id"
end
