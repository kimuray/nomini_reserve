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

ActiveRecord::Schema.define(version: 20171216150254) do

  create_table "admins", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "bank_accounts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.string "bank_name"
    t.string "bank_branch_name"
    t.string "bank_account_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_bank_accounts_on_user_id"
  end

  create_table "cities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.integer "prefecture_id", null: false
    t.string "city_code", null: false
    t.integer "big_city_flag", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_code"], name: "index_cities_on_city_code", unique: true
    t.index ["prefecture_id"], name: "index_cities_on_prefecture_id"
  end

  create_table "enquete_answers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "enquete_item_id"
    t.bigint "enquete_id"
    t.text "string_value"
    t.integer "integer_value"
    t.boolean "boolean_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["enquete_id"], name: "index_enquete_answers_on_enquete_id"
    t.index ["enquete_item_id"], name: "index_enquete_answers_on_enquete_item_id"
  end

  create_table "enquete_items", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text "content", null: false
    t.integer "answer_type", default: 0, null: false
    t.boolean "invalid_flg", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "select_value"
  end

  create_table "enquete_selections", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "enquete_item_id"
    t.string "content"
    t.integer "answer_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["enquete_item_id", "answer_value"], name: "index_enquete_selections_on_enquete_item_id_and_answer_value", unique: true
    t.index ["enquete_item_id"], name: "index_enquete_selections_on_enquete_item_id"
  end

  create_table "enquetes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "reservation_id"
    t.date "answer_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reservation_id"], name: "index_enquetes_on_reservation_id"
  end

  create_table "exchanges", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.integer "point", default: 0, null: false
    t.integer "status", default: 0
    t.datetime "paied_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "remand_reason"
    t.index ["user_id"], name: "index_exchanges_on_user_id"
  end

  create_table "introductions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.integer "introduced_user_id"
    t.string "introduced_email"
    t.string "introduction_token"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "introduced_user_id"], name: "index_introductions_on_user_id_and_introduced_user_id", unique: true
    t.index ["user_id"], name: "index_introductions_on_user_id"
  end

  create_table "prefectures", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reservation_benefits", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "point"
    t.integer "use_price"
    t.integer "reservation_id"
    t.integer "user_id"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reservation_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reservation_payments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "reservation_id"
    t.string "payjp_token_id"
    t.string "currency", default: "jpy", null: false
    t.integer "amount", default: 0, null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "limited_on"
    t.string "customer_id"
    t.index ["reservation_id"], name: "index_reservation_payments_on_reservation_id"
    t.index ["user_id"], name: "index_reservation_payments_on_user_id"
  end

  create_table "reservations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "shop_id"
    t.bigint "user_id"
    t.bigint "reservation_category_id"
    t.integer "people_count", null: false
    t.date "use_date", null: false
    t.time "use_time", null: false
    t.text "message"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_alacarte", default: false, null: false
    t.index ["reservation_category_id"], name: "index_reservations_on_reservation_category_id"
    t.index ["shop_id"], name: "index_reservations_on_shop_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "shop_usages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "shop_id"
    t.bigint "reservation_category_id"
    t.decimal "price", precision: 10
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reservation_category_id"], name: "index_shop_usages_on_reservation_category_id"
    t.index ["shop_id", "reservation_category_id"], name: "index_shop_usages_on_shop_id_and_reservation_category_id", unique: true
    t.index ["shop_id"], name: "index_shop_usages_on_shop_id"
  end

  create_table "shops", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.text "description"
    t.string "image"
    t.float "service_time", limit: 24
    t.string "price"
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "city_code"
    t.integer "prefecture_id"
    t.text "area_text"
    t.text "address_detail"
    t.boolean "is_agree", default: false, null: false
    t.index ["email"], name: "index_shops_on_email", unique: true
    t.index ["reset_password_token"], name: "index_shops_on_reset_password_token", unique: true
  end

  create_table "subscriptions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.integer "status", default: 1
    t.string "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "next_charge_on", null: false
    t.date "trail_finished_on", null: false
    t.index ["customer_id"], name: "index_subscriptions_on_customer_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "l_name"
    t.string "f_name"
    t.string "l_name_kana"
    t.string "f_name_kana"
    t.string "phone_number"
    t.string "enterprise_name"
    t.string "occupation"
    t.string "uid"
    t.string "provider"
    t.integer "point_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "monthly_usage_amount", default: 0, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "bank_accounts", "users"
  add_foreign_key "enquete_answers", "enquete_items"
  add_foreign_key "enquete_answers", "enquetes"
  add_foreign_key "enquete_selections", "enquete_items"
  add_foreign_key "enquetes", "reservations"
  add_foreign_key "exchanges", "users"
  add_foreign_key "introductions", "users"
  add_foreign_key "reservation_payments", "reservations"
  add_foreign_key "reservation_payments", "users"
  add_foreign_key "reservations", "reservation_categories"
  add_foreign_key "reservations", "shops"
  add_foreign_key "reservations", "users"
  add_foreign_key "shop_usages", "reservation_categories"
  add_foreign_key "shop_usages", "shops"
  add_foreign_key "subscriptions", "users"
end
