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

ActiveRecord::Schema.define(version: 2021_05_06_142131) do

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
    t.index ["number"], name: "unique_shop_order", unique: true
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

  create_table "permissions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.boolean "super_admin", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "reject_tags", default: 1, null: false
    t.index ["user_id"], name: "index_permissions_on_user_id"
    t.index ["user_id"], name: "unique_permissions_user", unique: true
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
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "comments", "users"
  add_foreign_key "permissions", "users"
  add_foreign_key "quality_reject_tag_loads", "quality_reject_tags", column: "reject_tag_id"
  add_foreign_key "quality_reject_tags", "as400_shop_orders", column: "shop_order_id"
  add_foreign_key "quality_reject_tags", "quality_reject_tags", column: "source_id"
  add_foreign_key "quality_reject_tags", "users"
  add_foreign_key "reviews", "users"
end
