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

ActiveRecord::Schema.define(version: 2021_10_25_081440) do

  create_table "play_quests", force: :cascade do |t|
    t.integer "user_id"
    t.integer "quest_id"
    t.boolean "clear", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "deleted", default: false, null: false
  end

  create_table "play_spots", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "spot_id", null: false
    t.integer "play_quest_id", null: false
    t.boolean "clear", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "deleted", default: false, null: false
  end

  create_table "quests", force: :cascade do |t|
    t.text "title"
    t.text "caption"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.boolean "publish", default: false, null: false
  end

  create_table "spots", force: :cascade do |t|
    t.integer "quest_id"
    t.text "q_text"
    t.string "answer"
    t.text "a_text"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "lat"
    t.float "lng"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image_name"
    t.string "password_digest"
  end

end
