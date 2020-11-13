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

ActiveRecord::Schema.define(version: 2020_11_12_193724) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendance_types", primary_key: "code", id: :string, force: :cascade do |t|
    t.string "description", null: false
  end

  create_table "attendances", force: :cascade do |t|
    t.bigint "seller_id", null: false
    t.bigint "store_id", null: false
    t.bigint "product_id"
    t.string "attendance_type_code", null: false
    t.string "lost_reason_code"
    t.datetime "start_at", null: false
    t.datetime "end_at", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index "date_trunc('day'::text, start_at)", name: "index_attendances_on_date_trunc_day_start_at"
    t.index ["attendance_type_code"], name: "index_attendances_on_attendance_type_code"
    t.index ["lost_reason_code"], name: "index_attendances_on_lost_reason_code"
    t.index ["product_id"], name: "index_attendances_on_product_id"
    t.index ["seller_id"], name: "index_attendances_on_seller_id"
    t.index ["store_id"], name: "index_attendances_on_store_id"
  end

  create_table "brands", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "lost_reasons", primary_key: "code", id: :string, force: :cascade do |t|
    t.string "description", null: false
  end

  create_table "movement_types", primary_key: "code", id: :string, force: :cascade do |t|
    t.string "description", null: false
  end

  create_table "movements", force: :cascade do |t|
    t.bigint "seller_id", null: false
    t.bigint "store_id", null: false
    t.string "movement_type_code", null: false
    t.datetime "date_time", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["seller_id"], name: "index_movements_on_seller_id"
    t.index ["store_id"], name: "index_movements_on_store_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "description", null: false
    t.bigint "brand_id", null: false
    t.index ["brand_id"], name: "index_products_on_brand_id"
  end

  create_table "sellers", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "store_id", null: false
    t.index ["store_id"], name: "index_sellers_on_store_id"
  end

  create_table "stores", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "brand_id", null: false
    t.index ["brand_id"], name: "index_stores_on_brand_id"
  end

  add_foreign_key "attendances", "attendance_types", column: "attendance_type_code", primary_key: "code"
  add_foreign_key "attendances", "lost_reasons", column: "lost_reason_code", primary_key: "code"
  add_foreign_key "attendances", "products"
  add_foreign_key "attendances", "sellers"
  add_foreign_key "attendances", "stores"
  add_foreign_key "movements", "movement_types", column: "movement_type_code", primary_key: "code"
  add_foreign_key "movements", "sellers"
  add_foreign_key "movements", "stores"
  add_foreign_key "products", "brands"
  add_foreign_key "sellers", "stores"
  add_foreign_key "stores", "brands"
end
