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

ActiveRecord::Schema.define(version: 2020_08_16_153307) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendance_types", force: :cascade do |t|
    t.string "description", null: false
  end

  create_table "attendances", force: :cascade do |t|
    t.bigint "seller_id", null: false
    t.bigint "store_id", null: false
    t.bigint "attendance_type_id", null: false
    t.datetime "start_at", null: false
    t.datetime "end_at", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["attendance_type_id"], name: "index_attendances_on_attendance_type_id"
    t.index ["seller_id"], name: "index_attendances_on_seller_id"
    t.index ["store_id"], name: "index_attendances_on_store_id"
  end

  create_table "attendances_lost_reasons", id: false, force: :cascade do |t|
    t.bigint "attendance_id", null: false
    t.bigint "lost_reason_id", null: false
    t.index ["attendance_id"], name: "index_attendances_lost_reasons_on_attendance_id"
    t.index ["lost_reason_id"], name: "index_attendances_lost_reasons_on_lost_reason_id"
  end

  create_table "attendances_products", id: false, force: :cascade do |t|
    t.bigint "attendance_id", null: false
    t.bigint "product_id", null: false
    t.index ["attendance_id"], name: "index_attendances_products_on_attendance_id"
    t.index ["product_id"], name: "index_attendances_products_on_product_id"
  end

  create_table "lost_reasons", force: :cascade do |t|
    t.string "description", null: false
  end

  create_table "movement_types", force: :cascade do |t|
    t.string "description", null: false
  end

  create_table "movements", force: :cascade do |t|
    t.bigint "seller_id", null: false
    t.bigint "store_id", null: false
    t.bigint "movement_type_id", null: false
    t.datetime "date_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["movement_type_id"], name: "index_movements_on_movement_type_id"
    t.index ["seller_id"], name: "index_movements_on_seller_id"
    t.index ["store_id"], name: "index_movements_on_store_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "description", null: false
  end

  create_table "sellers", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "stores", force: :cascade do |t|
    t.string "name", null: false
    t.string "brand", null: false
  end

  add_foreign_key "attendances", "attendance_types"
  add_foreign_key "attendances", "sellers"
  add_foreign_key "attendances", "stores"
  add_foreign_key "attendances_lost_reasons", "attendances"
  add_foreign_key "attendances_lost_reasons", "lost_reasons"
  add_foreign_key "attendances_products", "attendances"
  add_foreign_key "attendances_products", "products"
  add_foreign_key "movements", "movement_types"
  add_foreign_key "movements", "sellers"
  add_foreign_key "movements", "stores"
end
