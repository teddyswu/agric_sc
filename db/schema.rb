# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20191023094004) do

  create_table "authorizations", force: :cascade do |t|
    t.string   "provider",   limit: 255
    t.string   "uid",        limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "auto_replies", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.text     "url",             limit: 65535
    t.string   "default_pair",    limit: 255
    t.string   "triggering_pair", limit: 255
    t.boolean  "enabled"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "auto_reply_messages", force: :cascade do |t|
    t.integer  "auto_reply_id", limit: 4
    t.string   "cat",           limit: 255
    t.text     "content",       limit: 65535
    t.integer  "group_id",      limit: 4
    t.boolean  "is_default"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "auto_reply_replies", force: :cascade do |t|
    t.integer  "auto_reply_id", limit: 4
    t.string   "cat",           limit: 255
    t.text     "content",       limit: 65535
    t.integer  "group_id",      limit: 4
    t.boolean  "is_default"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "auto_reply_rules", force: :cascade do |t|
    t.integer  "auto_reply_id", limit: 4
    t.string   "rule_type",     limit: 255
    t.string   "rule",          limit: 255
    t.integer  "parent_id",     limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "category_work_ships", force: :cascade do |t|
    t.integer  "farming_category_id", limit: 4
    t.integer  "work_project_id",     limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",    limit: 255, null: false
    t.string   "data_content_type", limit: 255
    t.integer  "data_file_size",    limit: 4
    t.string   "type",              limit: 30
    t.integer  "width",             limit: 4
    t.integer  "height",            limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "ckeditor_assets", ["type"], name: "index_ckeditor_assets_on_type", using: :btree

  create_table "consultation_cates", force: :cascade do |t|
    t.integer  "consultation_id", limit: 4
    t.string   "name",            limit: 255
    t.text     "intro",           limit: 65535
    t.text     "pic",             limit: 65535
    t.integer  "sort",            limit: 4
    t.boolean  "enabled"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "consultation_contents", force: :cascade do |t|
    t.integer  "consultation_option_id", limit: 4
    t.integer  "gender",                 limit: 4
    t.integer  "age_range",              limit: 4
    t.text     "intro",                  limit: 65535
    t.text     "pic",                    limit: 65535
    t.text     "content",                limit: 65535
    t.boolean  "enabled"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "consultation_options", force: :cascade do |t|
    t.integer  "consultation_cate_id", limit: 4
    t.string   "name",                 limit: 255
    t.integer  "sort",                 limit: 4
    t.boolean  "enabled"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "consultations", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.integer  "cat",            limit: 4
    t.text     "json",           limit: 65535
    t.string   "title",          limit: 255
    t.text     "pic",            limit: 65535
    t.text     "intro",          limit: 65535
    t.string   "button_name",    limit: 255
    t.boolean  "enabled"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "parameter_name", limit: 255
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0, null: false
    t.integer  "attempts",   limit: 4,     default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "digital_resource_ships", force: :cascade do |t|
    t.string   "resource_type", limit: 255,   null: false
    t.integer  "resource_id",   limit: 4,     null: false
    t.string   "keyword",       limit: 255
    t.text     "encryption",    limit: 65535, null: false
    t.text     "title",         limit: 65535, null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "domains", force: :cascade do |t|
    t.text     "def_season", limit: 65535
    t.text     "def_week",   limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "farmer_interactive_tag_ships", force: :cascade do |t|
    t.integer  "farmer_interactive_id",     limit: 4
    t.integer  "farmer_interactive_tag_id", limit: 4
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "farmer_interactive_tags", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "farmer_interactives", force: :cascade do |t|
    t.string   "title",        limit: 255
    t.text     "content",      limit: 65535
    t.integer  "owner_id",     limit: 4
    t.date     "release_time"
    t.boolean  "enabled"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "farmer_profile_farming_category_ships", force: :cascade do |t|
    t.integer  "farmer_profile_id",   limit: 4
    t.integer  "farming_category_id", limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "farmer_profile_user_ships", force: :cascade do |t|
    t.integer  "farmer_profile_id", limit: 4
    t.integer  "user_id",           limit: 4
    t.integer  "permission",        limit: 4
    t.string   "uid",               limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "farmer_profiles", force: :cascade do |t|
    t.integer  "user_id",             limit: 4
    t.text     "user_pic_url",        limit: 65535
    t.string   "email",               limit: 255
    t.text     "pic_url",             limit: 65535
    t.text     "fb_url",              limit: 65535
    t.integer  "ps_group_id",         limit: 4
    t.string   "farm_name",           limit: 255
    t.string   "tel",                 limit: 255
    t.string   "cell_phone",          limit: 255
    t.text     "address",             limit: 65535
    t.text     "certification_body",  limit: 65535
    t.string   "category",            limit: 255
    t.integer  "verification_status", limit: 4
    t.string   "crop_name",           limit: 255
    t.text     "introduce",           limit: 65535
    t.text     "certificate_photo",   limit: 65535
    t.string   "oc_num",              limit: 255
    t.datetime "validity_period"
    t.boolean  "status"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "farming_categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "fb_bindings", force: :cascade do |t|
    t.text     "binding_ip",  limit: 65535
    t.text     "scoped_id",   limit: 65535
    t.string   "module_name", limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "fb_to_aws", force: :cascade do |t|
    t.string   "file",       limit: 255
    t.text     "cover_url",  limit: 65535
    t.text     "origin_url", limit: 65535
    t.text     "show_url",   limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "fb_tracks", force: :cascade do |t|
    t.string   "scoped_id",   limit: 255
    t.integer  "campaign_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "file_lists", force: :cascade do |t|
    t.string   "file",       limit: 255
    t.text     "url",        limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "filed_codes", force: :cascade do |t|
    t.integer  "user_id",         limit: 4
    t.string   "filed_code_name", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "generic_jsons", force: :cascade do |t|
    t.integer  "generic_keyword_id", limit: 4
    t.text     "json",               limit: 65535
    t.integer  "cat",                limit: 4
    t.integer  "wording_json_id",    limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "generic_keywords", force: :cascade do |t|
    t.text     "keyword",      limit: 65535
    t.integer  "keyword_type", limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "greetings", force: :cascade do |t|
    t.string   "uid",        limit: 255
    t.string   "name",       limit: 255
    t.text     "ref",        limit: 65535
    t.boolean  "start"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "group_user_ships", force: :cascade do |t|
    t.integer  "group_id",   limit: 4
    t.string   "uid",        limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "headlines", force: :cascade do |t|
    t.string   "resource_type", limit: 255
    t.integer  "resource_id",   limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "message_pushes", force: :cascade do |t|
    t.string   "module_name",     limit: 255
    t.text     "delayed_job_id",  limit: 65535
    t.datetime "run_at"
    t.integer  "delivery_number", limit: 4
    t.integer  "read_number",     limit: 4
    t.integer  "total_number",    limit: 4
    t.text     "purpose",         limit: 65535
    t.datetime "complete_time"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "group_id",        limit: 4
  end

  create_table "parameter_jsons", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.string   "def_name",           limit: 255
    t.text     "json",               limit: 65535
    t.integer  "parameter_set_id",   limit: 4
    t.string   "parameter_set_type", limit: 255
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "parameter_sets", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "ref",             limit: 255
    t.text     "guest",           limit: 65535
    t.text     "subscribe_guest", limit: 65535
    t.text     "user",            limit: 65535
    t.integer  "cat",             limit: 4
    t.integer  "wording_id",      limit: 4
    t.boolean  "enabled"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "personal_interplays", force: :cascade do |t|
    t.string   "qr_name",     limit: 255
    t.text     "start_model", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "ps_groups", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "image_url",  limit: 255
    t.string   "subtitle",   limit: 255
    t.boolean  "enabled"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "reply_words", force: :cascade do |t|
    t.string   "category",   limit: 255
    t.string   "show_name",  limit: 255
    t.datetime "start_time"
    t.datetime "end_time"
    t.boolean  "enabled"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "specify_jsons", force: :cascade do |t|
    t.integer  "specify_keyword_id", limit: 4
    t.text     "json",               limit: 65535
    t.integer  "cat",                limit: 4
    t.integer  "wording_json_id",    limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "specify_keywords", force: :cascade do |t|
    t.string   "resource_type", limit: 255
    t.integer  "resource_id",   limit: 4
    t.string   "pl_name",       limit: 255
    t.string   "role",          limit: 255
    t.integer  "keyword_type",  limit: 4
    t.text     "keyword",       limit: 65535
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "stories", force: :cascade do |t|
    t.string   "title",           limit: 255
    t.text     "content",         limit: 65535
    t.string   "owner",           limit: 255
    t.integer  "story_cat_id",    limit: 4
    t.string   "easter_egg_name", limit: 255
    t.text     "easter_egg_url",  limit: 65535
    t.boolean  "enabled"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "story_cats", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "story_images", force: :cascade do |t|
    t.integer  "story_id",     limit: 4
    t.string   "file",         limit: 255
    t.text     "url_headline", limit: 65535
    t.text     "url_cover",    limit: 65535
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "story_tag_ships", force: :cascade do |t|
    t.integer  "story_id",     limit: 4
    t.integer  "story_tag_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "story_tags", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "type_articles", force: :cascade do |t|
    t.text     "web_url",     limit: 65535
    t.text     "content",     limit: 65535
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "type_comics", force: :cascade do |t|
    t.text     "web_url",    limit: 65535
    t.text     "pic_1_url",  limit: 65535
    t.text     "pic_2_url",  limit: 65535
    t.text     "pic_3_url",  limit: 65535
    t.text     "pic_4_url",  limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "type_gifs", force: :cascade do |t|
    t.text     "url",        limit: 65535, null: false
    t.string   "file",       limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "type_movies", force: :cascade do |t|
    t.text     "pic_url",     limit: 65535
    t.text     "movie_url",   limit: 65535
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "user_analyzes", force: :cascade do |t|
    t.string   "uid",        limit: 255
    t.text     "pl",         limit: 65535
    t.text     "ref",        limit: 65535
    t.string   "age",        limit: 255
    t.string   "name",       limit: 255
    t.string   "type",       limit: 255
    t.string   "url",        limit: 255
    t.string   "text",       limit: 255
    t.text     "watermarks", limit: 65535
    t.text     "status",     limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "user_behaviors", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.text     "scoped_id",  limit: 65535
    t.string   "payload",    limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "user_data", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.text     "user_data",  limit: 65535
    t.string   "file_type",  limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "user_farming_category_ships", force: :cascade do |t|
    t.integer  "user_id",             limit: 4
    t.integer  "farming_category_id", limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "user_images", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "file",       limit: 255
    t.text     "url",        limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "user_subscriptions", force: :cascade do |t|
    t.string   "scoped_id",  limit: 255
    t.string   "full_name",  limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "cat",        limit: 4
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255,   default: "", null: false
    t.text     "encryption",             limit: 65535
    t.string   "encrypted_password",     limit: 255,   default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.boolean  "is_admin"
    t.boolean  "is_farmer"
    t.boolean  "is_check_farmer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "wording_cats", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "wording_jsons", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "def_name",   limit: 255
    t.text     "json",       limit: 65535
    t.integer  "wording_id", limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "wordings", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.text     "content",        limit: 65535
    t.integer  "wording_cat_id", limit: 4
    t.boolean  "enabled"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "work_diaries", force: :cascade do |t|
    t.integer  "owner_id",   limit: 4
    t.text     "comment",    limit: 65535
    t.datetime "diary_time"
    t.integer  "smile",      limit: 4
    t.integer  "general",    limit: 4
    t.integer  "dislike",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "work_diary_images", force: :cascade do |t|
    t.integer  "work_diary_id", limit: 4
    t.text     "url",           limit: 65535
    t.text     "cover_url",     limit: 65535
    t.text     "origin_url",    limit: 65535
    t.text     "show_url",      limit: 65535
    t.boolean  "enabled"
    t.string   "filter",        limit: 255
    t.integer  "position",      limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "work_diary_moods", force: :cascade do |t|
    t.integer  "work_diary_id", limit: 4
    t.integer  "user_id",       limit: 4
    t.integer  "mood",          limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "work_projects", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.integer  "record_type", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "work_record_image_logs", force: :cascade do |t|
    t.integer  "work_record_log_id", limit: 4
    t.text     "url",                limit: 65535
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "work_record_images", force: :cascade do |t|
    t.integer  "work_record_id", limit: 4
    t.text     "url",            limit: 65535
    t.text     "cover_url",      limit: 65535
    t.text     "origin_url",     limit: 65535
    t.text     "show_url",       limit: 65535
    t.boolean  "enabled"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "work_record_logs", force: :cascade do |t|
    t.string   "farming_category", limit: 255
    t.string   "filed_code",       limit: 255
    t.string   "owner_id",         limit: 255
    t.string   "record_type",      limit: 255
    t.string   "weight",           limit: 255
    t.datetime "work_time"
    t.string   "work_project",     limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "work_record_moods", force: :cascade do |t|
    t.integer  "work_record_id", limit: 4
    t.integer  "user_id",        limit: 4
    t.integer  "mood",           limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "work_record_replies", force: :cascade do |t|
    t.integer  "work_record_id", limit: 4
    t.integer  "user_id",        limit: 4
    t.text     "content",        limit: 65535
    t.boolean  "enabled"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "work_records", force: :cascade do |t|
    t.string   "farming_category", limit: 255
    t.string   "filed_code",       limit: 255
    t.integer  "owner_id",         limit: 4
    t.integer  "record_type",      limit: 4
    t.float    "weight",           limit: 24
    t.datetime "work_time"
    t.integer  "smile",            limit: 4
    t.integer  "general",          limit: 4
    t.integer  "dislike",          limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "work_project",     limit: 255
  end

end
