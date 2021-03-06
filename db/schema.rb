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

ActiveRecord::Schema.define(version: 20161221112056) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "inventories", force: :cascade do |t|
    t.decimal "amount"
    t.integer "user_id"
    t.integer "spools_id"
    t.index ["spools_id"], name: "index_inventories_on_spools_id", using: :btree
    t.index ["user_id"], name: "index_inventories_on_user_id", using: :btree
  end

  create_table "projects", force: :cascade do |t|
    t.string  "name"
    t.integer "user_id"
    t.index ["user_id"], name: "index_projects_on_user_id", using: :btree
  end

  create_table "projects_spools", force: :cascade do |t|
    t.integer "project_id"
    t.integer "spool_id"
    t.index ["project_id"], name: "index_projects_spools_on_project_id", using: :btree
    t.index ["spool_id"], name: "index_projects_spools_on_spool_id", using: :btree
  end

  create_table "shopping_lists", force: :cascade do |t|
    t.integer "user_id"
    t.integer "spools_id"
    t.integer "amount"
    t.index ["spools_id"], name: "index_shopping_lists_on_spools_id", using: :btree
    t.index ["user_id"], name: "index_shopping_lists_on_user_id", using: :btree
  end

  create_table "spools", force: :cascade do |t|
    t.string "dmc"
    t.string "name"
    t.string "rgb"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
