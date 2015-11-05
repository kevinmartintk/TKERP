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

ActiveRecord::Schema.define(version: 20150424135708) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.string "iso",      null: false
    t.string "slug"
    t.float  "drawdown"
    t.float  "igv"
    t.index ["slug"], :name => "index_countries_on_slug", :unique => true
  end

  create_table "clients", force: :cascade do |t|
    t.string   "name",           null: false
    t.string   "address",        null: false
    t.string   "legal_id"
    t.string   "slug"
    t.integer  "country_id"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "corporate_name"
    t.index ["country_id"], :name => "fk__clients_country_id"
    t.index ["deleted_at"], :name => "index_clients_on_deleted_at"
    t.index ["slug"], :name => "index_clients_on_slug", :unique => true
    t.foreign_key ["country_id"], "countries", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_clients_country_id"
  end

  create_table "collaborators", force: :cascade do |t|
    t.string   "name"
    t.string   "last_name"
    t.string   "dni"
    t.date     "birthday"
    t.string   "mail"
    t.string   "mobile"
    t.string   "skype"
    t.string   "em_number"
    t.string   "contact"
    t.string   "address"
    t.date     "start_day"
    t.datetime "deleted_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.float    "salary",       null: false
    t.integer  "relationship", null: false
    t.integer  "currency",     null: false
    t.string   "calendar"
    t.integer  "team"
    t.index ["deleted_at"], :name => "index_collaborators_on_deleted_at"
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "email",      null: false
    t.string   "phone",      null: false
    t.string   "mobile"
    t.date     "birthday"
    t.string   "slug"
    t.integer  "client_id"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["client_id"], :name => "fk__contacts_client_id"
    t.index ["deleted_at"], :name => "index_contacts_on_deleted_at"
    t.index ["slug"], :name => "index_contacts_on_slug", :unique => true
    t.foreign_key ["client_id"], "clients", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_contacts_client_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",             default: "",   null: false
    t.string   "last_name",              default: "",   null: false
    t.string   "image",                  default: "",   null: false
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "uid",                    default: "",   null: false
    t.string   "provider",               default: "",   null: false
    t.string   "token",                  default: "",   null: false
    t.string   "refresh_token",          default: "",   null: false
    t.integer  "expires_at",             default: 0,    null: false
    t.boolean  "expires",                default: true, null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "slug"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "team"
    t.index ["deleted_at"], :name => "index_users_on_deleted_at"
    t.index ["email"], :name => "index_users_on_email", :unique => true
    t.index ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
    t.index ["slug"], :name => "index_users_on_slug", :unique => true
  end

  create_table "prospects", force: :cascade do |t|
    t.integer  "client_id"
    t.integer  "country_id"
    t.integer  "prospect_type"
    t.integer  "account_id"
    t.integer  "team"
    t.integer  "status"
    t.string   "observation"
    t.date     "approved_at"
    t.string   "name"
    t.date     "arrival_date"
    t.date     "arrival_team_date"
    t.datetime "deleted_at"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["account_id"], :name => "fk__prospects_account_id"
    t.index ["client_id"], :name => "fk__prospects_client_id"
    t.index ["country_id"], :name => "fk__prospects_country_id"
    t.index ["deleted_at"], :name => "index_prospects_on_deleted_at"
    t.index ["slug"], :name => "index_prospects_on_slug", :unique => true
    t.foreign_key ["account_id"], "users", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_prospects_account_id"
    t.foreign_key ["client_id"], "clients", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_prospects_client_id"
    t.foreign_key ["country_id"], "countries", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_prospects_country_id"
  end

  create_table "technologies", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "estimations", force: :cascade do |t|
    t.integer  "prospect_id"
    t.integer  "technology_id"
    t.integer  "estimation_type"
    t.integer  "developers"
    t.float    "days"
    t.float    "hours"
    t.float    "hours_per_day"
    t.date     "sent_at"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["prospect_id"], :name => "fk__estimations_prospect_id"
    t.index ["technology_id"], :name => "fk__estimations_technology_id"
    t.foreign_key ["prospect_id"], "prospects", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_estimations_prospect_id"
    t.foreign_key ["technology_id"], "technologies", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_estimations_technology_id"
  end

  create_table "events", force: :cascade do |t|
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "name",                            null: false
    t.datetime "start"
    t.datetime "finish"
    t.text     "description",                     null: false
    t.boolean  "all_day",         default: false, null: false
    t.integer  "collaborator_id",                 null: false
    t.index ["collaborator_id"], :name => "fk__events_collaborator_id"
    t.index ["name"], :name => "index_events_on_name"
    t.foreign_key ["collaborator_id"], "collaborators", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_events_collaborator_id"
  end

  create_table "headquarters", force: :cascade do |t|
    t.string   "image_file_name",    null: false
    t.string   "image_content_type", null: false
    t.integer  "image_file_size",    null: false
    t.datetime "image_updated_at",   null: false
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["country_id"], :name => "fk__headquarters_country_id"
    t.foreign_key ["country_id"], "countries", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_headquarters_country_id"
  end

  create_table "inventories", force: :cascade do |t|
    t.string   "name"
    t.string   "brand"
    t.string   "writer"
    t.string   "edition"
    t.string   "editorial"
    t.string   "model"
    t.integer  "team"
    t.integer  "inventory_type_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.text     "description"
    t.integer  "copies"
    t.string   "serie"
    t.date     "reg_date"
    t.datetime "deleted_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["inventory_type_id"], :name => "index_inventories_on_inventory_type_id"
  end

  create_table "inventory_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoices", force: :cascade do |t|
    t.text     "description",                 null: false
    t.integer  "currency",                    null: false
    t.float    "amount",                      null: false
    t.integer  "status",                      null: false
    t.boolean  "has_drawdown"
    t.string   "extra"
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
    t.text     "message"
    t.string   "slug"
    t.integer  "headquarter_id"
    t.integer  "client_id"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "invoice_number"
    t.string   "invoice_pdf_file_name"
    t.string   "invoice_pdf_content_type"
    t.integer  "invoice_pdf_file_size"
    t.datetime "invoice_pdf_updated_at"
    t.string   "purchase_order_file_name"
    t.string   "purchase_order_content_type"
    t.integer  "purchase_order_file_size"
    t.datetime "purchase_order_updated_at"
    t.index ["client_id"], :name => "fk__invoices_client_id"
    t.index ["deleted_at"], :name => "index_invoices_on_deleted_at"
    t.index ["headquarter_id"], :name => "fk__invoices_headquarter_id"
    t.index ["slug"], :name => "index_invoices_on_slug", :unique => true
    t.foreign_key ["client_id"], "clients", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_invoices_client_id"
    t.foreign_key ["headquarter_id"], "headquarters", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_invoices_headquarter_id"
  end

  create_table "invoice_contacts", force: :cascade do |t|
    t.integer  "invoice_id"
    t.integer  "contact_id"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["contact_id"], :name => "fk__invoice_contacts_contact_id"
    t.index ["deleted_at"], :name => "index_invoice_contacts_on_deleted_at"
    t.index ["invoice_id"], :name => "fk__invoice_contacts_invoice_id"
    t.foreign_key ["contact_id"], "contacts", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_invoice_contacts_contact_id"
    t.foreign_key ["invoice_id"], "invoices", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_invoice_contacts_invoice_id"
  end

  create_table "prospect_contacts", force: :cascade do |t|
    t.integer  "prospect_id", null: false
    t.integer  "contact_id",  null: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["contact_id"], :name => "fk__prospect_contacts_contact_id"
    t.index ["deleted_at"], :name => "index_prospect_contacts_on_deleted_at"
    t.index ["prospect_id"], :name => "fk__prospect_contacts_prospect_id"
    t.foreign_key ["contact_id"], "contacts", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_prospect_contacts_contact_id"
    t.foreign_key ["prospect_id"], "prospects", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_prospect_contacts_prospect_id"
  end

  create_table "quotations", force: :cascade do |t|
    t.integer  "prospect_id",                  null: false
    t.float    "price_per_hour", default: 0.0, null: false
    t.float    "total",          default: 0.0, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["prospect_id"], :name => "fk__quotations_prospect_id"
    t.foreign_key ["prospect_id"], "prospects", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_quotations_prospect_id"
  end

  create_table "quotation_estimations", force: :cascade do |t|
    t.float    "days_est",      default: 0.0, null: false
    t.float    "hours_est",     default: 0.0, null: false
    t.float    "price",         default: 0.0, null: false
    t.integer  "quotation_id",                null: false
    t.integer  "estimation_id",               null: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "selected"
    t.index ["deleted_at"], :name => "index_quotation_estimations_on_deleted_at"
    t.index ["estimation_id"], :name => "fk__quotation_estimations_estimation_id"
    t.index ["quotation_id"], :name => "fk__quotation_estimations_quotation_id"
    t.foreign_key ["estimation_id"], "estimations", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_quotation_estimations_estimation_id"
    t.foreign_key ["quotation_id"], "quotations", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_quotation_estimations_quotation_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schedules", force: :cascade do |t|
    t.integer  "collaborator_id", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["collaborator_id"], :name => "fk__schedules_collaborator_id"
    t.foreign_key ["collaborator_id"], "collaborators", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_schedules_collaborator_id"
  end

end
