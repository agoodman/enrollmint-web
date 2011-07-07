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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110707194032) do

  create_table "apps", :force => true do |t|
    t.string    "title"
    t.integer   "user_id"
    t.string    "bundle_identifier"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "post_back_url"
  end

  create_table "couriers", :force => true do |t|
    t.string    "post_back_url"
    t.integer   "subscription_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "customers", :force => true do |t|
    t.integer   "user_id"
    t.string    "email"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "secret_key"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer   "priority",   :default => 0
    t.integer   "attempts",   :default => 0
    t.text      "handler"
    t.text      "last_error"
    t.timestamp "run_at"
    t.timestamp "locked_at"
    t.timestamp "failed_at"
    t.text      "locked_by"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "products", :force => true do |t|
    t.integer   "user_id"
    t.string    "identifier"
    t.integer   "duration"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.float     "price"
    t.string    "secret_key"
    t.integer   "app_id"
  end

  create_table "receipts", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quantity"
    t.string   "transaction_id"
    t.datetime "purchase_date"
    t.datetime "expiration_date"
    t.integer  "subscription_id"
  end

  create_table "subscriptions", :force => true do |t|
    t.integer  "customer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "product_id"
    t.string   "secret_key"
    t.datetime "expiration_date"
  end

  create_table "users", :force => true do |t|
    t.string    "email"
    t.string    "encrypted_password",        :limit => 128
    t.string    "salt",                      :limit => 128
    t.string    "confirmation_token",        :limit => 128
    t.string    "remember_token",            :limit => 128
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.boolean   "terms_of_service_accepted",                :default => false
    t.string    "first_name"
    t.string    "last_name"
    t.string    "api_token"
    t.string    "shared_secret"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
