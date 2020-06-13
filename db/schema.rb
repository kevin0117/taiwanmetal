# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_13_063801) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "online", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "price_boards", force: :cascade do |t|
    t.datetime "price_date", default: -> { "CURRENT_TIMESTAMP" }
    t.decimal "gold_selling"
    t.decimal "gold_buying"
    t.decimal "platinum_selling"
    t.decimal "platinum_buying"
    t.decimal "wholesale_gold_selling"
    t.decimal "wholesale_gold_buying"
    t.decimal "wholesale_platinum_selling"
    t.decimal "wholesale_platinum_buying"
    t.text "description"
    t.boolean "online"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "product_lists", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.text "description"
    t.boolean "online", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "title"
    t.decimal "weight"
    t.decimal "cost", default: "0.0"
    t.decimal "service_fee"
    t.string "barcode"
    t.boolean "on_sell", default: true
    t.string "code"
    t.datetime "deleted_at"
    t.bigint "product_list_id", null: false
    t.bigint "vendor_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "price_board_id", null: false
    t.index ["code"], name: "index_products_on_code", unique: true
    t.index ["deleted_at"], name: "index_products_on_deleted_at"
    t.index ["price_board_id"], name: "index_products_on_price_board_id"
    t.index ["product_list_id"], name: "index_products_on_product_list_id"
    t.index ["user_id"], name: "index_products_on_user_id"
    t.index ["vendor_id"], name: "index_products_on_vendor_id"
  end

  create_table "scraps", force: :cascade do |t|
    t.datetime "collected_date", default: -> { "CURRENT_TIMESTAMP" }
    t.string "title"
    t.decimal "gross_weight"
    t.decimal "wastage_rate", default: "0.95"
    t.decimal "net_weight"
    t.decimal "gold_buying"
    t.decimal "total_price"
    t.boolean "in_stock", default: true
    t.string "code"
    t.datetime "deleted_at"
    t.bigint "customer_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_scraps_on_customer_id"
    t.index ["user_id"], name: "index_scraps_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.boolean "admin"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.string "image"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vendors", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "online", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "products", "price_boards"
  add_foreign_key "products", "product_lists"
  add_foreign_key "products", "users"
  add_foreign_key "products", "vendors"
  add_foreign_key "scraps", "customers"
  add_foreign_key "scraps", "users"
end
