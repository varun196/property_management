# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_10_01_020053) do

  create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "companies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "website"
    t.text "address"
    t.integer "employee_count"
    t.integer "foundation_year"
    t.string "revenue"
    t.text "synopsis"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "househunters", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.integer "phone"
    t.string "contact_method"
    t.bigint "users_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["users_id"], name: "index_househunters_on_users_id"
  end

  create_table "houses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "companies_id"
    t.text "location"
    t.string "area"
    t.integer "year_built"
    t.string "style"
    t.integer "list_prize"
    t.integer "floor_count"
    t.boolean "basement"
    t.string "owner_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "realtor_id"
    t.index ["companies_id"], name: "index_houses_on_companies_id"
  end

  create_table "inquiries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "subject"
    t.text "content"
    t.bigint "users_id"
    t.bigint "houses_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["houses_id"], name: "index_inquiries_on_houses_id"
    t.index ["users_id"], name: "index_inquiries_on_users_id"
  end

  create_table "realtors", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.bigint "companies_id"
    t.integer "phone_number"
    t.bigint "users_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["companies_id"], name: "index_realtors_on_companies_id"
    t.index ["users_id"], name: "index_realtors_on_users_id"
  end

  create_table "realtors_houses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "realtors_id"
    t.bigint "houses_id"
    t.index ["houses_id"], name: "index_realtors_houses_on_houses_id"
    t.index ["realtors_id"], name: "index_realtors_houses_on_realtors_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email_id"
    t.string "password"
    t.boolean "is_admin"
    t.boolean "is_realtor"
    t.boolean "is_househunter"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "househunters", "users", column: "users_id"
  add_foreign_key "houses", "companies", column: "companies_id"
  add_foreign_key "inquiries", "houses", column: "houses_id"
  add_foreign_key "inquiries", "users", column: "users_id"
  add_foreign_key "realtors", "companies", column: "companies_id"
  add_foreign_key "realtors", "users", column: "users_id"
  add_foreign_key "realtors_houses", "houses", column: "houses_id"
  add_foreign_key "realtors_houses", "realtors", column: "realtors_id"
end
