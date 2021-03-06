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

ActiveRecord::Schema.define(version: 20151228172830) do

  create_table "comic_tags", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "tag_id"
    t.integer  "comic_id"
  end

  add_index "comic_tags", ["comic_id"], name: "index_comic_tags_on_comic_id"
  add_index "comic_tags", ["tag_id"], name: "index_comic_tags_on_tag_id"

  create_table "comics", force: :cascade do |t|
    t.string   "page_url"
    t.string   "img_url"
    t.date     "publish_date"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "comic_title"
  end

  create_table "tags", force: :cascade do |t|
    t.string   "tagname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
