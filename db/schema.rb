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

ActiveRecord::Schema[7.0].define(version: 2023_08_04_132630) do
  create_table "dice", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "shortcode", null: false
    t.integer "title"
    t.integer "game_id"
    t.index ["game_id"], name: "index_dice_on_game_id"
    t.index ["shortcode"], name: "index_dice_on_shortcode", unique: true
  end

  create_table "games", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ideas", force: :cascade do |t|
    t.string "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ideas_rolls", id: false, force: :cascade do |t|
    t.integer "idea_id", null: false
    t.integer "roll_id", null: false
  end

  create_table "rolls", force: :cascade do |t|
    t.integer "side_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["side_id"], name: "index_rolls_on_side_id"
  end

  create_table "sides", force: :cascade do |t|
    t.integer "die_id", null: false
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "shortcode", null: false
    t.text "variations"
    t.index ["die_id"], name: "index_sides_on_die_id"
    t.index ["shortcode", "die_id"], name: "index_sides_on_shortcode_and_die_id", unique: true
  end

  add_foreign_key "dice", "games"
  add_foreign_key "rolls", "sides"
  add_foreign_key "sides", "dice"
end
