# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_190_715_104_251) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'contributors', force: :cascade do |t|
    t.string 'type'
    t.bigint 'version_id'
    t.bigint 'developer_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['developer_id'], name: 'index_contributors_on_developer_id'
    t.index ['type'], name: 'index_contributors_on_type'
    t.index ['version_id'], name: 'index_contributors_on_version_id'
  end

  create_table 'developers', force: :cascade do |t|
    t.string 'name'
    t.string 'email'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'packages', force: :cascade do |t|
    t.string 'name', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['name'], name: 'index_packages_on_name', unique: true
  end

  create_table 'versions', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'title'
    t.integer 'status', default: 0
    t.bigint 'package_id'
    t.text 'description'
    t.date 'publication'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['package_id'], name: 'index_versions_on_package_id'
  end

  add_foreign_key 'contributors', 'developers'
  add_foreign_key 'contributors', 'versions'
  add_foreign_key 'versions', 'packages'
end
