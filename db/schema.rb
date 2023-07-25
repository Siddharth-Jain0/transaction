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

ActiveRecord::Schema[7.0].define(version: 2023_07_24_135227) do
  create_table "chats", force: :cascade do |t|
    t.integer "sender_id"
    t.integer "reciever_id"
    t.string "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reciever_id"], name: "index_chats_on_reciever_id"
    t.index ["sender_id"], name: "index_chats_on_sender_id"
  end

  create_table "emis", force: :cascade do |t|
    t.integer "loan_id"
    t.integer "month"
    t.decimal "interest"
    t.decimal "principal"
    t.decimal "closing_balance"
    t.decimal "total_payment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.date "due_date"
    t.decimal "penalty", default: "0.0"
    t.index ["loan_id"], name: "index_emis_on_loan_id"
  end

  create_table "loans", force: :cascade do |t|
    t.integer "user_id"
    t.decimal "principal"
    t.decimal "monthly_rate"
    t.decimal "time"
    t.decimal "emi_amount"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "previous_loan_id"
    t.index ["user_id"], name: "index_loans_on_user_id"
  end

  create_table "transaction_histories", force: :cascade do |t|
    t.integer "sender_id"
    t.integer "reciever_id"
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.string "option"
    t.index ["reciever_id"], name: "index_transaction_histories_on_reciever_id"
    t.index ["sender_id"], name: "index_transaction_histories_on_sender_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "upi"
    t.string "name"
    t.integer "role", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wallets", force: :cascade do |t|
    t.decimal "balance"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "bank_name"
    t.integer "pin", default: 1234
    t.index ["user_id"], name: "index_wallets_on_user_id"
  end

  add_foreign_key "loans", "users"
  add_foreign_key "wallets", "users"
end
