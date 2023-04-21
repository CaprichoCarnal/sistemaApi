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

ActiveRecord::Schema[7.0].define(version: 2023_04_21_165838) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "channels", force: :cascade do |t|
    t.bigint "family_id", null: false
    t.bigint "supplier_id", null: false
    t.date "born_date"
    t.string "born_in"
    t.string "raised_in"
    t.date "slaughter_date"
    t.string "slaughtered_in"
    t.string "crotal"
    t.string "lot"
    t.float "weight"
    t.float "temperature"
    t.string "classification"
    t.boolean "available"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["family_id"], name: "index_channels_on_family_id"
    t.index ["supplier_id"], name: "index_channels_on_supplier_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "fiscal_name"
    t.string "commercial_name"
    t.string "address"
    t.string "postal_code"
    t.string "city"
    t.string "province"
    t.string "country"
    t.string "document_type"
    t.string "document"
    t.string "name"
    t.string "phone"
    t.string "mobile"
    t.string "email"
    t.string "bank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "document_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "families", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string "postal_code"
    t.string "city"
    t.string "province"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "fiscal_name"
    t.string "commercial_name"
    t.string "address"
    t.string "postal_code"
    t.string "city"
    t.string "province"
    t.string "country"
    t.string "document_type"
    t.string "document"
    t.string "phone"
    t.string "mobile"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "supplies", force: :cascade do |t|
    t.bigint "supplier_id", null: false
    t.string "lot"
    t.string "name"
    t.integer "quantity"
    t.float "weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["supplier_id"], name: "index_supplies_on_supplier_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.bigint "role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "channels", "families"
  add_foreign_key "channels", "suppliers"
  add_foreign_key "supplies", "suppliers"
  add_foreign_key "users", "roles"
end
