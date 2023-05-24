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

ActiveRecord::Schema[7.0].define(version: 2023_05_24_143104) do
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
    t.index ["raw_material_id"], name: "index_cuts_on_raw_material_id"
  end

  create_table "document_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "elaborated_product_materials", force: :cascade do |t|
    t.bigint "elaborated_product_id", null: false
    t.bigint "supply_id", null: false
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["elaborated_product_id"], name: "index_elaborated_product_materials_on_elaborated_product_id"
    t.index ["supply_id"], name: "index_elaborated_product_materials_on_supply_id"
  end

  create_table "elaborated_products", force: :cascade do |t|
    t.string "name"
    t.integer "weight"
    t.string "lot"
    t.string "description"
    t.bigint "cut_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cut_id"], name: "index_elaborated_products_on_cut_id"
  end

  create_table "families", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "historic_quarterings", force: :cascade do |t|
    t.date "date"
    t.string "id_channel"
    t.string "piece_name"
    t.string "lot"
    t.string "operator_signature"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "historical_elaborations", force: :cascade do |t|
    t.date "date"
    t.string "product_name"
    t.string "ingredients"
    t.string "lot_number"
    t.string "final_lot_number"
    t.string "final_weight"
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

  create_table "piecenames", force: :cascade do |t|
    t.bigint "family_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["family_id"], name: "index_piecenames_on_family_id"
  end

  create_table "process_histories", force: :cascade do |t|
    t.date "date"
    t.string "material_name"
    t.string "material_lot_number"
    t.string "product_name"
    t.string "product_lot_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "purchase_supplies", force: :cascade do |t|
    t.string "date_of_purchase"
    t.bigint "supplier_id", null: false
    t.string "invoice_code"
    t.string "item"
    t.string "description"
    t.string "lot"
    t.integer "quantity"
    t.integer "price"
    t.integer "discount"
    t.integer "total"
    t.integer "vat"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["supplier_id"], name: "index_purchase_supplies_on_supplier_id"
  end

  create_table "raw_material_purchases", force: :cascade do |t|
    t.date "date_of_purchase"
    t.bigint "supplier_id", null: false
    t.string "invoice_code"
    t.string "item"
    t.bigint "family_id", null: false
    t.string "description"
    t.string "lot"
    t.integer "quantity"
    t.integer "price"
    t.integer "discount"
    t.integer "total"
    t.integer "vat"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["family_id"], name: "index_raw_material_purchases_on_family_id"
    t.index ["supplier_id"], name: "index_raw_material_purchases_on_supplier_id"
  end

  create_table "raw_materials", force: :cascade do |t|
    t.bigint "raw_material_purchase_id", null: false
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
    t.string "available"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["family_id"], name: "index_raw_materials_on_family_id"
    t.index ["raw_material_purchase_id"], name: "index_raw_materials_on_raw_material_purchase_id"
    t.index ["supplier_id"], name: "index_raw_materials_on_supplier_id"
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

  add_foreign_key "article_names", "families"
  add_foreign_key "cuts", "raw_materials"
  add_foreign_key "elaborated_product_materials", "elaborated_products"
  add_foreign_key "elaborated_product_materials", "supplies"
  add_foreign_key "elaborated_products", "cuts"
  add_foreign_key "piecenames", "families"
  add_foreign_key "purchase_supplies", "suppliers"
  add_foreign_key "raw_material_purchases", "families"
  add_foreign_key "raw_material_purchases", "suppliers"
  add_foreign_key "raw_materials", "families"
  add_foreign_key "raw_materials", "raw_material_purchases"
  add_foreign_key "raw_materials", "suppliers"
  add_foreign_key "supplies", "suppliers"
  add_foreign_key "users", "roles"
end
