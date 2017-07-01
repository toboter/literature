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

ActiveRecord::Schema.define(version: 20170629225503) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comment_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id",   null: false
    t.integer "descendant_id", null: false
    t.integer "generations",   null: false
    t.index ["ancestor_id", "descendant_id", "generations"], name: "comment_anc_desc_udx", unique: true, using: :btree
    t.index ["descendant_id"], name: "comment_desc_idx", using: :btree
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.string   "title"
    t.text     "body"
    t.string   "subject"
    t.integer  "commentator_id",   null: false
    t.integer  "parent_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
    t.index ["commentator_id"], name: "index_comments_on_commentator_id", using: :btree
  end

  create_table "creators", force: :cascade do |t|
    t.string   "fname"
    t.string   "lname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "creatorships", force: :cascade do |t|
    t.integer  "creator_id"
    t.integer  "subject_id"
    t.integer  "position"
    t.string   "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_creatorships_on_creator_id", using: :btree
    t.index ["subject_id"], name: "index_creatorships_on_subject_id", using: :btree
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.string   "provider"
    t.string   "gid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "identifiers", force: :cascade do |t|
    t.integer  "subject_id"
    t.string   "ident_name"
    t.string   "ident_value"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["subject_id"], name: "index_identifiers_on_subject_id", using: :btree
  end

  create_table "memberships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id", "user_id"], name: "index_memberships_on_group_id_and_user_id", unique: true, using: :btree
    t.index ["group_id"], name: "index_memberships_on_group_id", using: :btree
    t.index ["user_id"], name: "index_memberships_on_user_id", using: :btree
  end

  create_table "places", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "publishers", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "record_activities", force: :cascade do |t|
    t.integer  "actor_id"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.string   "activity_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["resource_id", "resource_type", "activity_type"], name: "index_record_activities_on_resource_and_activity", unique: true, using: :btree
    t.index ["resource_type", "resource_id"], name: "index_record_activities_on_resource_type_and_resource_id", using: :btree
  end

  create_table "series", force: :cascade do |t|
    t.string   "name"
    t.string   "abbr"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "share_models", force: :cascade do |t|
    t.string   "resource_type"
    t.integer  "resource_id"
    t.string   "shared_to_type"
    t.integer  "shared_to_id"
    t.string   "shared_from_type"
    t.integer  "shared_from_id"
    t.boolean  "edit"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["resource_id", "resource_type", "shared_to_id", "shared_to_type"], name: "index_share_models_on_resource_and_shared_to", unique: true, using: :btree
    t.index ["resource_type", "resource_id"], name: "index_share_models_on_resource_type_and_resource_id", using: :btree
    t.index ["shared_from_type", "shared_from_id"], name: "index_share_models_on_shared_from_type_and_shared_from_id", using: :btree
    t.index ["shared_to_type", "shared_to_id"], name: "index_share_models_on_shared_to_type_and_shared_to_id", using: :btree
  end

  create_table "subject_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id",   null: false
    t.integer "descendant_id", null: false
    t.integer "generations",   null: false
    t.index ["ancestor_id", "descendant_id", "generations"], name: "subject_anc_desc_idx", unique: true, using: :btree
    t.index ["descendant_id"], name: "subject_desc_idx", using: :btree
  end

  create_table "subjects", force: :cascade do |t|
    t.string   "slug"
    t.string   "title"
    t.string   "subtitle"
    t.string   "type"
    t.integer  "parent_id"
    t.string   "first_page"
    t.string   "last_page"
    t.string   "page_count"
    t.string   "volume"
    t.string   "published_date"
    t.string   "abbr"
    t.string   "edition"
    t.string   "language"
    t.integer  "publisher_id"
    t.integer  "place_id"
    t.string   "g_volume_id"
    t.string   "g_canonical_link"
    t.string   "g_image_thumbnail"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.text     "g_description"
    t.integer  "serie_id"
    t.string   "url_code"
    t.string   "citation"
    t.integer  "cite_seq_id"
    t.string   "cite"
    t.string   "extra_pages"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.string   "taggable_type"
    t.integer  "taggable_id"
    t.string   "tagger_type"
    t.integer  "tagger_id"
    t.string   "context",       limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context", using: :btree
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
    t.index ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy", using: :btree
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id", using: :btree
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type", using: :btree
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type", using: :btree
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "email"
    t.string   "birthday"
    t.string   "gender"
    t.boolean  "app_admin"
    t.string   "token"
    t.boolean  "app_commentator"
    t.boolean  "app_creator"
    t.boolean  "app_publisher"
  end

  add_foreign_key "creatorships", "creators"
  add_foreign_key "creatorships", "subjects"
  add_foreign_key "identifiers", "subjects"
  add_foreign_key "memberships", "groups"
  add_foreign_key "memberships", "users"
end
