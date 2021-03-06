# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_10_080746) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "email"
    t.string "password"
    t.datetime "last_checked_at"
    t.integer "unread_count"
    t.string "error"
    t.integer "priority", default: 0
    t.string "heroku_app_name"
    t.index ["email"], name: "index_accounts_on_email"
    t.index ["last_checked_at"], name: "index_accounts_on_last_checked_at"
    t.index ["priority"], name: "index_accounts_on_priority"
  end

  create_table "mail_contents", force: :cascade do |t|
    t.integer "account_id"
    t.string "message_id"
    t.string "from"
    t.string "to"
    t.string "cc"
    t.string "subject"
    t.text "text_part"
    t.text "html_part"
    t.datetime "created_at"
    t.boolean "is_multipart"
    t.boolean "is_read"
    t.index ["account_id"], name: "index_mail_contents_on_account_id"
    t.index ["created_at"], name: "index_mail_contents_on_created_at"
    t.index ["message_id"], name: "index_mail_contents_on_message_id"
  end

end
