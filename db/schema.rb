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

ActiveRecord::Schema.define(version: 20180614200339) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "billing_profiles", force: :cascade do |t|
    t.bigint "user_id"
    t.string "email", null: false
    t.string "person_name", null: false
    t.string "company_name"
    t.string "phone"
    t.string "address"
    t.string "city"
    t.string "postal_code"
    t.string "country"
    t.string "account_owner"
    t.string "iban"
    t.string "swift_code"
    t.string "currency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_billing_profiles_on_user_id"
  end

  create_table "clients", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name", null: false
    t.string "email"
    t.string "contact_person_name"
    t.string "contact_person_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "auto_send", default: false
    t.index ["name"], name: "index_clients_on_name"
    t.index ["user_id"], name: "index_clients_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "client_id"
    t.string "title", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_projects_on_client_id"
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "user_id"
    t.bigint "client_id"
    t.string "title"
    t.float "price"
    t.json "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_tasks_on_client_id"
    t.index ["project_id"], name: "index_tasks_on_project_id"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "time_entries", force: :cascade do |t|
    t.bigint "task_id"
    t.bigint "user_id"
    t.datetime "start_at", null: false
    t.datetime "end_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_time_entries_on_task_id"
    t.index ["user_id"], name: "index_time_entries_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "timezone", default: "UTC"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

end
