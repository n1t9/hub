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

ActiveRecord::Schema[7.2].define(version: 2024_12_27_004935) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.string "icon", null: false
    t.integer "sequence", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories_official_posts", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "official_post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_categories_official_posts_on_category_id"
    t.index ["official_post_id"], name: "index_categories_official_posts_on_official_post_id"
  end

  create_table "official_post_bookmarks", force: :cascade do |t|
    t.bigint "official_post_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["official_post_id", "user_id"], name: "index_official_post_bookmarks_on_official_post_id_and_user_id", unique: true
    t.index ["official_post_id"], name: "index_official_post_bookmarks_on_official_post_id"
    t.index ["user_id"], name: "index_official_post_bookmarks_on_user_id"
  end

  create_table "official_posts", force: :cascade do |t|
    t.string "title", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "page_followers", force: :cascade do |t|
    t.bigint "page_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["page_id", "user_id"], name: "index_page_followers_on_page_id_and_user_id", unique: true
    t.index ["page_id"], name: "index_page_followers_on_page_id"
    t.index ["user_id"], name: "index_page_followers_on_user_id"
  end

  create_table "page_managers", force: :cascade do |t|
    t.bigint "page_id", null: false
    t.bigint "user_id", null: false
    t.integer "role", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["page_id", "user_id"], name: "index_page_managers_on_page_id_and_user_id", unique: true
    t.index ["page_id"], name: "index_page_managers_on_page_id"
    t.index ["user_id"], name: "index_page_managers_on_user_id"
  end

  create_table "page_post_bookmarks", force: :cascade do |t|
    t.bigint "page_post_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["page_post_id", "user_id"], name: "index_page_post_bookmarks_on_page_post_id_and_user_id", unique: true
    t.index ["page_post_id"], name: "index_page_post_bookmarks_on_page_post_id"
    t.index ["user_id"], name: "index_page_post_bookmarks_on_user_id"
  end

  create_table "page_posts", force: :cascade do |t|
    t.bigint "page_id", null: false
    t.string "title", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["page_id"], name: "index_page_posts_on_page_id"
  end

  create_table "page_reviews", force: :cascade do |t|
    t.bigint "page_id", null: false
    t.bigint "user_id", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["page_id"], name: "index_page_reviews_on_page_id"
    t.index ["user_id"], name: "index_page_reviews_on_user_id"
  end

  create_table "pages", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.string "name", null: false
    t.boolean "is_verified", default: false, null: false
    t.text "bio", null: false
    t.string "url", null: false
    t.integer "posts_count", default: 0, null: false
    t.integer "reviews_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["category_id"], name: "index_pages_on_category_id"
    t.index ["deleted_at"], name: "index_pages_on_deleted_at"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "session_token", null: false
    t.boolean "is_admin", default: false, null: false
    t.string "name", null: false
    t.string "display_name", null: false
    t.string "language", null: false
    t.text "background", null: false
    t.text "bio", null: false
    t.string "url", null: false
    t.integer "followings_count", default: 0, null: false
    t.integer "bookmarks_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["session_token"], name: "index_users_on_session_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "categories_official_posts", "categories"
  add_foreign_key "categories_official_posts", "official_posts"
  add_foreign_key "official_post_bookmarks", "official_posts"
  add_foreign_key "official_post_bookmarks", "users"
  add_foreign_key "page_followers", "pages"
  add_foreign_key "page_followers", "users"
  add_foreign_key "page_managers", "pages"
  add_foreign_key "page_managers", "users"
  add_foreign_key "page_post_bookmarks", "page_posts"
  add_foreign_key "page_post_bookmarks", "users"
  add_foreign_key "page_posts", "pages"
  add_foreign_key "page_reviews", "pages"
  add_foreign_key "page_reviews", "users"
  add_foreign_key "pages", "categories"
end
