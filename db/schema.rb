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

ActiveRecord::Schema.define(version: 20170611073236) do

  create_table "atrs", force: :cascade do |t|
    t.integer  "high_value_minus_before_end_value", limit: 4
    t.integer  "before_end_value_minus_low_value",  limit: 4
    t.integer  "high_value_minus__low_value",       limit: 4
    t.integer  "true_range",                        limit: 4
    t.integer  "average_true_range",                limit: 4
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.datetime "dates"
  end

  create_table "stocks", force: :cascade do |t|
    t.integer  "start_value",                       limit: 4
    t.integer  "high_value",                        limit: 4
    t.integer  "low_value",                         limit: 4
    t.integer  "end_value",                         limit: 4
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.datetime "dates"
    t.integer  "high_value_minus_before_end_value", limit: 4
    t.integer  "before_end_value_minus_low_value",  limit: 4
    t.integer  "high_value_minus__low_value",       limit: 4
    t.integer  "true_range",                        limit: 4
    t.integer  "average_true_range",                limit: 4
  end

end
