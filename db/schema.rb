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

ActiveRecord::Schema.define(version: 20150316205332) do

  create_table "countries", force: :cascade do |t|
    t.string "name",     limit: 255
    t.string "iso",      limit: 255, null: false
    t.string "slug",     limit: 255
    t.float  "drawdown", limit: 24
    t.float  "igv",      limit: 24
    t.index ["slug"], :name => "index_countries_on_slug", :unique => true
  end

  create_table "clients", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.string   "address",    limit: 255, null: false
    t.string   "legal_id",   limit: 255
    t.string   "slug",       limit: 255
    t.integer  "country_id", limit: 4
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["country_id"], :name => "fk__clients_country_id"
    t.index ["deleted_at"], :name => "index_clients_on_deleted_at"
    t.index ["slug"], :name => "index_clients_on_slug", :unique => true
    t.foreign_key ["country_id"], "countries", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_clients_country_id"
  end

  create_table "collaborators", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "last_name",    limit: 255
    t.string   "dni",          limit: 255
    t.date     "birthday"
    t.string   "mail",         limit: 255
    t.string   "mobile",       limit: 255
    t.string   "skype",        limit: 255
    t.string   "em_number",    limit: 255
    t.string   "contact",      limit: 255
    t.string   "address",      limit: 255
    t.date     "start_day"
    t.datetime "deleted_at"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.float    "salary",       limit: 24,  null: false
    t.integer  "relationship", limit: 4,   null: false
    t.integer  "currency",     limit: 4,   null: false
    t.string   "calendar",     limit: 255
    t.index ["deleted_at"], :name => "index_collaborators_on_deleted_at"
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.string   "email",      limit: 255, null: false
    t.string   "phone",      limit: 255, null: false
    t.string   "mobile",     limit: 255
    t.date     "birthday"
    t.string   "slug",       limit: 255
    t.integer  "client_id",  limit: 4
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["client_id"], :name => "fk__contacts_client_id"
    t.index ["deleted_at"], :name => "index_contacts_on_deleted_at"
    t.index ["slug"], :name => "index_contacts_on_slug", :unique => true
    t.foreign_key ["client_id"], "clients", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_contacts_client_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",             limit: 255, default: "",   null: false
    t.string   "last_name",              limit: 255, default: "",   null: false
    t.string   "image",                  limit: 255, default: "",   null: false
    t.string   "email",                  limit: 255, default: "",   null: false
    t.string   "encrypted_password",     limit: 255, default: "",   null: false
    t.string   "uid",                    limit: 255, default: "",   null: false
    t.string   "provider",               limit: 255, default: "",   null: false
    t.string   "token",                  limit: 255, default: "",   null: false
    t.string   "refresh_token",          limit: 255, default: "",   null: false
    t.integer  "expires_at",             limit: 4,   default: 0,    null: false
    t.boolean  "expires",                limit: 1,   default: true, null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "slug",                   limit: 255
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "team",                   limit: 4
    t.index ["deleted_at"], :name => "index_users_on_deleted_at"
    t.index ["email"], :name => "index_users_on_email", :unique => true
    t.index ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
    t.index ["slug"], :name => "index_users_on_slug", :unique => true
  end

  create_table "prospects", force: :cascade do |t|
    t.integer  "client_id",         limit: 4
    t.integer  "country_id",        limit: 4
    t.integer  "prospect_type",     limit: 4
    t.integer  "account_id",        limit: 4
    t.integer  "team",              limit: 4
    t.integer  "status",            limit: 4
    t.string   "observation",       limit: 255
    t.date     "approved_at"
    t.string   "name",              limit: 255
    t.date     "arrival_date"
    t.date     "arrival_team_date"
    t.datetime "deleted_at"
    t.string   "slug",              limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["account_id"], :name => "fk__prospects_account_id"
    t.index ["client_id"], :name => "fk__prospects_client_id"
    t.index ["country_id"], :name => "fk__prospects_country_id"
    t.index ["deleted_at"], :name => "index_prospects_on_deleted_at"
    t.index ["slug"], :name => "index_prospects_on_slug", :unique => true
    t.foreign_key ["account_id"], "users", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_prospects_account_id"
    t.foreign_key ["client_id"], "clients", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_prospects_client_id"
    t.foreign_key ["country_id"], "countries", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_prospects_country_id"
  end

  create_table "technologies", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "estimations", force: :cascade do |t|
    t.integer  "prospect_id",     limit: 4
    t.integer  "technology_id",   limit: 4
    t.integer  "estimation_type", limit: 4
    t.integer  "developers",      limit: 4
    t.float    "days",            limit: 24
    t.float    "hours",           limit: 24
    t.float    "hours_per_day",   limit: 24
    t.date     "sent_at"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["prospect_id"], :name => "fk__estimations_prospect_id"
    t.index ["technology_id"], :name => "fk__estimations_technology_id"
    t.foreign_key ["prospect_id"], "prospects", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_estimations_prospect_id"
    t.foreign_key ["technology_id"], "technologies", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_estimations_technology_id"
  end

  create_table "headquarters", force: :cascade do |t|
    t.string   "image_file_name",    limit: 255, null: false
    t.string   "image_content_type", limit: 255, null: false
    t.integer  "image_file_size",    limit: 4,   null: false
    t.datetime "image_updated_at",               null: false
    t.integer  "country_id",         limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["country_id"], :name => "fk__headquarters_country_id"
    t.foreign_key ["country_id"], "countries", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_headquarters_country_id"
  end

  create_table "inventories", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.string   "brand",              limit: 255
    t.string   "writer",             limit: 255
    t.string   "edition",            limit: 255
    t.string   "editorial",          limit: 255
    t.string   "model",              limit: 255
    t.integer  "team",               limit: 4
    t.integer  "inventory_type",     limit: 4
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.text     "description",        limit: 65535
    t.integer  "copies",             limit: 4
    t.string   "serie",              limit: 255
    t.date     "reg_date"
    t.datetime "deleted_at"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "inventory_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "invoices", force: :cascade do |t|
    t.text     "description",           limit: 65535, null: false
    t.integer  "currency",              limit: 4,     null: false
    t.float    "amount",                limit: 24,    null: false
    t.integer  "status",                limit: 4,     null: false
    t.boolean  "has_drawdown",          limit: 1
    t.string   "extra",                 limit: 255
    t.string   "document_file_name",    limit: 255
    t.string   "document_content_type", limit: 255
    t.integer  "document_file_size",    limit: 4
    t.datetime "document_updated_at"
    t.text     "message",               limit: 65535
    t.string   "slug",                  limit: 255
    t.integer  "headquarter_id",        limit: 4
    t.integer  "client_id",             limit: 4
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "invoice_number",        limit: 255
    t.index ["client_id"], :name => "fk__invoices_client_id"
    t.index ["deleted_at"], :name => "index_invoices_on_deleted_at"
    t.index ["headquarter_id"], :name => "fk__invoices_headquarter_id"
    t.index ["slug"], :name => "index_invoices_on_slug", :unique => true
    t.foreign_key ["client_id"], "clients", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_invoices_client_id"
    t.foreign_key ["headquarter_id"], "headquarters", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_invoices_headquarter_id"
  end

  create_table "invoice_contacts", force: :cascade do |t|
    t.integer  "invoice_id", limit: 4
    t.integer  "contact_id", limit: 4
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["contact_id"], :name => "fk__invoice_contacts_contact_id"
    t.index ["deleted_at"], :name => "index_invoice_contacts_on_deleted_at"
    t.index ["invoice_id"], :name => "fk__invoice_contacts_invoice_id"
    t.foreign_key ["contact_id"], "contacts", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_invoice_contacts_contact_id"
    t.foreign_key ["invoice_id"], "invoices", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_invoice_contacts_invoice_id"
  end

  create_table "prospect_contacts", force: :cascade do |t|
    t.integer  "prospect_id", limit: 4, null: false
    t.integer  "contact_id",  limit: 4, null: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["contact_id"], :name => "fk__prospect_contacts_contact_id"
    t.index ["deleted_at"], :name => "index_prospect_contacts_on_deleted_at"
    t.index ["prospect_id"], :name => "fk__prospect_contacts_prospect_id"
    t.foreign_key ["contact_id"], "contacts", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_prospect_contacts_contact_id"
    t.foreign_key ["prospect_id"], "prospects", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_prospect_contacts_prospect_id"
  end

  create_table "quotations", force: :cascade do |t|
    t.integer  "prospect_id",    limit: 4,                null: false
    t.float    "price_per_hour", limit: 24, default: 0.0, null: false
    t.float    "total",          limit: 24, default: 0.0, null: false
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.index ["prospect_id"], :name => "fk__quotations_prospect_id"
    t.foreign_key ["prospect_id"], "prospects", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_quotations_prospect_id"
  end

  create_table "quotation_estimations", force: :cascade do |t|
    t.float    "days_est",      limit: 24, default: 0.0, null: false
    t.float    "hours_est",     limit: 24, default: 0.0, null: false
    t.float    "price",         limit: 24, default: 0.0, null: false
    t.integer  "quotation_id",  limit: 4,                null: false
    t.integer  "estimation_id", limit: 4,                null: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "selected",      limit: 1
    t.index ["deleted_at"], :name => "index_quotation_estimations_on_deleted_at"
    t.index ["estimation_id"], :name => "fk__quotation_estimations_estimation_id"
    t.index ["quotation_id"], :name => "fk__quotation_estimations_quotation_id"
    t.foreign_key ["estimation_id"], "estimations", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_quotation_estimations_estimation_id"
    t.foreign_key ["quotation_id"], "quotations", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_quotation_estimations_quotation_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "schedules", force: :cascade do |t|
    t.integer  "collaborator_id", limit: 4, null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["collaborator_id"], :name => "fk__schedules_collaborator_id"
    t.foreign_key ["collaborator_id"], "collaborators", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_schedules_collaborator_id"
  end

end
