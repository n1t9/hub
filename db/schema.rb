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

ActiveRecord::Schema[7.2].define(version: 2024_10_27_134757) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "keywords", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.string "name", null: false
    t.integer "sequence", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_keywords_on_category_id"
  end

  create_table "official_post_bookmarks", force: :cascade do |t|
    t.bigint "official_post_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["official_post_id"], name: "index_official_post_bookmarks_on_official_post_id"
    t.index ["user_id"], name: "index_official_post_bookmarks_on_user_id"
  end

  create_table "official_posts", force: :cascade do |t|
    t.integer "status", null: false
    t.string "title", null: false
    t.text "content", null: false
    t.string "cover_image", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "page_followers", force: :cascade do |t|
    t.bigint "page_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["page_id"], name: "index_page_followers_on_page_id"
    t.index ["user_id"], name: "index_page_followers_on_user_id"
  end

  create_table "page_keywords", force: :cascade do |t|
    t.bigint "page_id", null: false
    t.bigint "keyword_id", null: false
    t.integer "sequence", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["keyword_id"], name: "index_page_keywords_on_keyword_id"
    t.index ["page_id"], name: "index_page_keywords_on_page_id"
  end

  create_table "page_post_bookmarks", force: :cascade do |t|
    t.bigint "page_post_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["page_post_id"], name: "index_page_post_bookmarks_on_page_post_id"
    t.index ["user_id"], name: "index_page_post_bookmarks_on_user_id"
  end

  create_table "page_posts", force: :cascade do |t|
    t.bigint "page_id", null: false
    t.bigint "user_id", null: false
    t.integer "status", null: false
    t.string "title", null: false
    t.text "content", null: false
    t.string "cover_image", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["page_id"], name: "index_page_posts_on_page_id"
    t.index ["user_id"], name: "index_page_posts_on_user_id"
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

  create_table "page_users", force: :cascade do |t|
    t.bigint "page_id", null: false
    t.bigint "user_id", null: false
    t.integer "role", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["page_id"], name: "index_page_users_on_page_id"
    t.index ["user_id"], name: "index_page_users_on_user_id"
  end

  create_table "pages", force: :cascade do |t|
    t.integer "genre", null: false
    t.string "name", null: false
    t.integer "status", null: false
    t.string "profile_image", null: false
    t.boolean "is_verified", default: false, null: false
    t.text "bio", null: false
    t.integer "posts_count", default: 0, null: false
    t.integer "reviews_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["genre"], name: "index_pages_on_genre"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "profile_image", null: false
    t.text "bio", null: false
    t.text "background", null: false
    t.string "language", null: false
    t.boolean "email_verified", default: false, null: false
    t.string "session_token", null: false
    t.integer "followings_count", default: 0, null: false
    t.integer "bookmarks_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["session_token"], name: "index_users_on_session_token", unique: true
  end

  add_foreign_key "keywords", "categories"
  add_foreign_key "official_post_bookmarks", "official_posts"
  add_foreign_key "official_post_bookmarks", "users"
  add_foreign_key "page_followers", "pages"
  add_foreign_key "page_followers", "users"
  add_foreign_key "page_keywords", "keywords"
  add_foreign_key "page_keywords", "pages"
  add_foreign_key "page_post_bookmarks", "page_posts"
  add_foreign_key "page_post_bookmarks", "users"
  add_foreign_key "page_posts", "pages"
  add_foreign_key "page_posts", "users"
  add_foreign_key "page_reviews", "pages"
  add_foreign_key "page_reviews", "users"
  add_foreign_key "page_users", "pages"
  add_foreign_key "page_users", "users"
end
