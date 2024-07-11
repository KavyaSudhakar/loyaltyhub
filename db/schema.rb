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

ActiveRecord::Schema[7.1].define(version: 2024_07_11_095412) do
  create_table "loyalty_tiers", force: :cascade do |t|
    t.string "name"
    t.integer "min_points"
    t.integer "max_points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_loyalty_tiers_on_name", unique: true
  end

  create_table "reward_types", force: :cascade do |t|
    t.string "reward_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "criteria"
  end

  create_table "rewards", force: :cascade do |t|
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "reward_type_id", null: false
    t.index ["reward_type_id"], name: "index_rewards_on_reward_type_id"
    t.index ["user_id"], name: "index_rewards_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "country"
    t.integer "points_earned", default: 0, null: false
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.date "birthdate"
    t.integer "loyalty_tier_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["loyalty_tier_id"], name: "index_users_on_loyalty_tier_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "rewards", "reward_types"
  add_foreign_key "rewards", "users"
  add_foreign_key "transactions", "users"
  add_foreign_key "users", "loyalty_tiers"
end
