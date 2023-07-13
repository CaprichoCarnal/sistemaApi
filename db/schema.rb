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

ActiveRecord::Schema[7.0].define(version: 2023_07_13_050936) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "article_names", force: :cascade do |t|
    t.bigint "family_id", null: false
    t.string "code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["family_id"], name: "index_article_names_on_family_id"
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

  create_table "cuts", force: :cascade do |t|
    t.bigint "raw_material_id", null: false
    t.string "name"
    t.string "lot"
    t.float "weight"
    t.boolean "matured"
    t.date "maturity_start_date"
    t.date "maturity_end_date"
    t.boolean "frozen"
    t.boolean "available_for_sale"
    t.string "prepared_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "expiration_date"
    t.boolean "finished"
    t.index ["raw_material_id"], name: "index_cuts_on_raw_material_id"
  end

  create_table "document_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

