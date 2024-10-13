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

ActiveRecord::Schema[7.2].define(version: 2024_10_13_045016) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "page_tags", force: :cascade do |t|
    t.bigint "page_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["page_id", "tag_id"], name: "index_page_tags_on_page_id_and_tag_id", unique: true
    t.index ["page_id"], name: "index_page_tags_on_page_id"
    t.index ["tag_id"], name: "index_page_tags_on_tag_id"
  end

  create_table "pages", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title", null: false
    t.string "slug", null: false
    t.text "summary", null: false
    t.text "content", null: false
    t.boolean "published", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_pages_on_created_at"
    t.index ["published"], name: "index_pages_on_published"
    t.index ["slug"], name: "index_pages_on_slug", unique: true
    t.index ["title"], name: "index_pages_on_title", unique: true
    t.index ["user_id"], name: "index_pages_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.integer "page_tags_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
    t.index ["page_tags_count"], name: "index_tags_on_page_tags_count"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name", unique: true
  end

  add_foreign_key "page_tags", "pages"
  add_foreign_key "page_tags", "tags"
  add_foreign_key "pages", "users"
end