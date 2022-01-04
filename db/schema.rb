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

ActiveRecord::Schema.define(version: 2022_01_04_060202) do

  create_table "comment_images", force: :cascade do |t|
    t.integer "comment_id", null: false
    t.string "comment_image_path"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["comment_id"], name: "index_comment_images_on_comment_id"
  end

  create_table "comments", force: :cascade do |t|
    t.integer "subject_id", null: false
    t.integer "user_id", null: false
    t.integer "parent_comment_id"
    t.text "comment_content"
    t.boolean "comment_is_checked"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["parent_comment_id"], name: "index_comments_on_parent_comment_id"
    t.index ["subject_id"], name: "index_comments_on_subject_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "course_directors", force: :cascade do |t|
    t.integer "subject_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["subject_id"], name: "index_course_directors_on_subject_id"
    t.index ["user_id"], name: "index_course_directors_on_user_id"
  end

  create_table "group_directors", force: :cascade do |t|
    t.integer "subject_id", null: false
    t.integer "group_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_id"], name: "index_group_directors_on_group_id"
    t.index ["subject_id"], name: "index_group_directors_on_subject_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "group_name"
    t.integer "group_grade"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "master_users", force: :cascade do |t|
    t.integer "school_id", null: false
    t.string "master_user_name"
    t.string "master_user_password"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["school_id"], name: "index_master_users_on_school_id"
  end

  create_table "notification_checks", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "notification_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["notification_id"], name: "index_notification_checks_on_notification_id"
    t.index ["user_id"], name: "index_notification_checks_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "group_id", null: false
    t.text "notification_content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_id"], name: "index_notifications_on_group_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "schools", force: :cascade do |t|
    t.string "school_name"
    t.string "school_image_path"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "subjects", force: :cascade do |t|
    t.integer "school_id", null: false
    t.string "subject_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["school_id"], name: "index_subjects_on_school_id"
  end

  create_table "users", force: :cascade do |t|
    t.integer "school_id", null: false
    t.integer "group_id", null: false
    t.string "user_name"
    t.string "user_password"
    t.boolean "user_is_student"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_id"], name: "index_users_on_group_id"
    t.index ["school_id"], name: "index_users_on_school_id"
  end

  create_table "votes", force: :cascade do |t|
    t.integer "comment_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["comment_id"], name: "index_votes_on_comment_id"
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

  add_foreign_key "comment_images", "comments"
  add_foreign_key "comments", "comments", column: "parent_comment_id"
  add_foreign_key "comments", "subjects"
  add_foreign_key "comments", "users"
  add_foreign_key "course_directors", "subjects"
  add_foreign_key "course_directors", "users"
  add_foreign_key "group_directors", "groups"
  add_foreign_key "group_directors", "subjects"
  add_foreign_key "master_users", "schools"
  add_foreign_key "notification_checks", "notifications"
  add_foreign_key "notification_checks", "users"
  add_foreign_key "notifications", "groups"
  add_foreign_key "notifications", "users"
  add_foreign_key "subjects", "schools"
  add_foreign_key "users", "groups"
  add_foreign_key "users", "schools"
  add_foreign_key "votes", "comments"
  add_foreign_key "votes", "users"
end
