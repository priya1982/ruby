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

ActiveRecord::Schema.define(version: 2019_05_28_091823) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "fuzzystrmatch"
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "account_journals", force: :cascade do |t|
    t.integer "consumer_location_id", null: false
    t.decimal "balance", precision: 20, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "business_id"
    t.index ["business_id"], name: "index_account_journals_on_business_id"
  end

  create_table "account_ledgers", force: :cascade do |t|
    t.datetime "transaction_date", null: false
    t.text "particular"
    t.decimal "previous_closing_balance", precision: 20, scale: 2, default: "0.0", null: false
    t.decimal "debit_amount", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "credit_amount", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "closing_balance", precision: 20, scale: 2, default: "0.0", null: false
    t.bigint "reference_id"
    t.string "reference_type"
    t.bigint "online_payment_ref_id"
    t.bigint "account_journal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_journal_id"], name: "index_account_ledgers_on_account_journal_id"
  end

  create_table "brands", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "business_id", null: false
    t.string "logo"
    t.boolean "active", default: true
    t.integer "products_count", default: 0
    t.index ["business_id"], name: "index_brands_on_business_id"
    t.index ["name", "business_id"], name: "index_brands_on_name_and_business_id", unique: true
  end

  create_table "business_associations", force: :cascade do |t|
    t.bigint "business_id"
    t.bigint "associated_business_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["associated_business_id"], name: "index_business_associations_on_associated_business_id"
    t.index ["business_id", "associated_business_id"], name: "businessassociation_unique_index", unique: true
    t.index ["business_id"], name: "index_business_associations_on_business_id"
  end

  create_table "business_categories", force: :cascade do |t|
    t.string "name"
    t.hstore "permissions", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "creator_id"
    t.integer "businesses_count", default: 0
    t.boolean "visible", default: true
    t.index ["name", "creator_id"], name: "index_business_categories_on_name_and_creator_id", unique: true
  end

  create_table "business_enquiries", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "business_invites", force: :cascade do |t|
    t.bigint "business_id"
    t.bigint "invited_business_id"
    t.bigint "user_id"
    t.bigint "accepted_user_id"
    t.boolean "accepted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accepted_user_id"], name: "index_business_invites_on_accepted_user_id"
    t.index ["business_id", "invited_business_id"], name: "index_business_invites_on_business_id_and_invited_business_id", unique: true
    t.index ["business_id"], name: "index_business_invites_on_business_id"
    t.index ["invited_business_id"], name: "index_business_invites_on_invited_business_id"
    t.index ["user_id"], name: "index_business_invites_on_user_id"
  end

  create_table "business_locations", force: :cascade do |t|
    t.integer "buyer_id"
    t.integer "supplier_id"
    t.integer "location_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_business_locations_on_user_id"
  end

  create_table "business_preferences", force: :cascade do |t|
    t.hstore "settings"
    t.string "feature"
    t.bigint "business_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_business_preferences_on_business_id"
    t.index ["settings"], name: "index_business_preferences_on_settings", using: :gin
  end

  create_table "businesses", force: :cascade do |t|
    t.string "name", null: false
    t.string "contact_email_1", null: false
    t.string "contact_number_1", null: false
    t.integer "business_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.integer "tenant_id"
    t.text "address_line_1", null: false
    t.integer "locations_count", default: 0, null: false
    t.bigint "creator_id"
    t.bigint "holder_id"
    t.string "city", null: false
    t.string "state", null: false
    t.string "postal_code", null: false
    t.string "contact_name_1", null: false
    t.string "designation_1", null: false
    t.string "contact_name_2"
    t.string "designation_2"
    t.string "contact_email_2"
    t.string "contact_number_2"
    t.text "description"
    t.boolean "active", default: true
    t.text "address_line_2"
    t.string "country_code_1", default: "+91"
    t.string "country_code_2", default: "+91"
    t.integer "country_id", null: false
    t.integer "currency_id"
    t.string "gstin"
    t.string "pan_no"
    t.integer "business_type"
    t.boolean "is_virtual_supplier", default: false
    t.integer "virtual_supplier_id"
    t.string "supplier_code"
    t.integer "sync_status"
    t.string "guid"
    t.string "remarks"
    t.boolean "is_modified", default: false
    t.index ["business_category_id"], name: "index_businesses_on_business_category_id"
    t.index ["creator_id"], name: "index_businesses_on_creator_id"
    t.index ["holder_id"], name: "index_businesses_on_holder_id"
    t.index ["tenant_id"], name: "index_businesses_on_tenant_id"
  end

  create_table "cart_items", force: :cascade do |t|
    t.integer "quantity", null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.bigint "user_id", null: false
    t.bigint "from_location_id", null: false
    t.bigint "to_location_id", null: false
    t.bigint "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["from_location_id"], name: "index_cart_items_on_from_location_id"
    t.index ["product_id"], name: "index_cart_items_on_product_id"
    t.index ["to_location_id"], name: "index_cart_items_on_to_location_id"
    t.index ["user_id"], name: "index_cart_items_on_user_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name", null: false
    t.index ["name"], name: "index_countries_on_name", unique: true
  end

  create_table "currencies", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.string "symbol", default: "\\u20b9", null: false
  end

  create_table "delivery_order_histories", force: :cascade do |t|
    t.integer "do_id"
    t.string "status"
    t.hstore "change"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "or_id"
    t.string "preferred_delivery_time"
    t.bigint "delivery_order_id"
    t.index ["delivery_order_id"], name: "index_delivery_order_histories_on_delivery_order_id"
  end

  create_table "delivery_order_items", force: :cascade do |t|
    t.bigint "delivery_order_id", null: false
    t.bigint "product_id", null: false
    t.float "quantity", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.decimal "rate", precision: 10, scale: 2
    t.decimal "total_product_cost", precision: 10, scale: 2
    t.decimal "average_product_cost", precision: 10, scale: 2
    t.date "actual_delivery_at"
    t.bigint "business_id"
    t.bigint "supplier_id"
    t.decimal "cgst", precision: 10, scale: 2
    t.decimal "sgst", precision: 10, scale: 2
    t.decimal "tot_item_price", precision: 10, scale: 2
    t.index ["delivery_order_id"], name: "index_delivery_order_items_on_delivery_order_id"
    t.index ["product_id"], name: "index_delivery_order_items_on_product_id"
  end

# Could not dump table "delivery_orders" because of following StandardError
#   Unknown type 'delivery_confirmation_type' for column 'delivery_confirmation_type'

# Could not dump table "drivers" because of following StandardError
#   Unknown type 'licence_type' for column 'licence_type'

  create_table "gst_businesses", force: :cascade do |t|
    t.string "status"
    t.date "registration_date"
    t.string "business"
    t.string "gstin"
    t.string "dealer_type"
    t.string "trade_name"
    t.string "entity_type"
    t.string "pan"
    t.string "legal_name"
    t.string "floor"
    t.string "street"
    t.string "bno"
    t.string "bname"
    t.string "city"
    t.string "pincode"
    t.string "state"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "indent_products_lists", force: :cascade do |t|
    t.bigint "indent_id"
    t.bigint "product_id"
    t.integer "qty"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["indent_id"], name: "index_indent_products_lists_on_indent_id"
    t.index ["product_id"], name: "index_indent_products_lists_on_product_id"
  end

  create_table "indents", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "business_id", null: false
    t.bigint "location_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_indents_on_business_id"
    t.index ["location_id"], name: "index_indents_on_location_id"
    t.index ["user_id"], name: "index_indents_on_user_id"
  end

  create_table "intra_transfers", force: :cascade do |t|
    t.bigint "business_id"
    t.integer "from_location"
    t.integer "to_location"
    t.bigint "product_id"
    t.integer "qty"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_intra_transfers_on_business_id"
    t.index ["product_id"], name: "index_intra_transfers_on_product_id"
  end

# Could not dump table "inventories" because of following StandardError
#   Unknown type 'inventory_type' for column 'type'

# Could not dump table "inventory_histories" because of following StandardError
#   Unknown type 'movement_type' for column 'movement_type'

  create_table "inventory_reports", force: :cascade do |t|
    t.datetime "closing_date", null: false
    t.integer "product_id", null: false
    t.integer "inventory_holder_id", null: false
    t.string "inventory_holder_type", null: false
    t.integer "sellable_quantity", null: false
    t.integer "deliverable_quantity", null: false
    t.integer "returnable_quantity", null: false
    t.integer "unsorted_quantity", null: false
  end

  create_table "last_known_locations", force: :cascade do |t|
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "pick_up_location"
    t.integer "user_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name", null: false
    t.string "contact_name_1", null: false
    t.string "contact_phone_1", null: false
    t.string "contact_email_1", null: false
    t.boolean "redistribution_centre", default: false
    t.bigint "business_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "address_line_1", null: false
    t.float "latitude"
    t.float "longitude"
    t.text "address_line_2"
    t.string "city", null: false
    t.string "state", null: false
    t.string "pin_code", null: false
    t.string "area", null: false
    t.string "contact_designation_1", null: false
    t.string "contact_name_2"
    t.string "contact_designation_2"
    t.string "contact_email_2"
    t.string "contact_phone_2"
    t.string "country_code_1", default: "+91"
    t.string "country_code_2", default: "+91"
    t.integer "country_id", null: false
    t.index ["business_id"], name: "index_locations_on_business_id"
  end

# Could not dump table "order_histories" because of following StandardError
#   Unknown type 'order_history_statuses' for column 'order_history_status'

# Could not dump table "order_request_histories" because of following StandardError
#   Unknown type 'order_history_statues' for column 'order_history_status'

  create_table "order_request_lists", force: :cascade do |t|
    t.bigint "order_request_id"
    t.bigint "product_id"
    t.float "qty_req"
    t.float "qty_conf"
    t.decimal "price", precision: 10, scale: 2, null: false
    t.boolean "is_serviced", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "unit_price", precision: 10, scale: 2
    t.index ["order_request_id"], name: "index_order_request_lists_on_order_request_id"
    t.index ["product_id"], name: "index_order_request_lists_on_product_id"
  end

  create_table "order_request_template_lists", force: :cascade do |t|
    t.bigint "product_id"
    t.float "quantity"
    t.bigint "order_request_template_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_request_template_id"], name: "index_order_request_template_lists_on_order_request_template_id"
    t.index ["product_id"], name: "index_order_request_template_lists_on_product_id"
  end

  create_table "order_request_templates", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "business_id"
    t.bigint "location_id"
    t.bigint "supplier_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_order_request_templates_on_business_id"
    t.index ["location_id"], name: "index_order_request_templates_on_location_id"
    t.index ["supplier_id"], name: "index_order_request_templates_on_supplier_id"
    t.index ["user_id"], name: "index_order_request_templates_on_user_id"
  end

# Could not dump table "order_requests" because of following StandardError
#   Unknown type 'order_statuses' for column 'customer_status'

  create_table "payment_account_informations", force: :cascade do |t|
    t.string "ifsc_code", null: false
    t.string "account_number", null: false
    t.string "re_account_number"
    t.integer "business_id"
    t.string "beneficiary_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status"
    t.string "account_business_name", null: false
    t.string "account_email", null: false
    t.string "business_type"
    t.string "razor_payment_account"
    t.index ["account_number"], name: "index_payment_account_informations_on_account_number", unique: true
  end

  create_table "payment_histories", force: :cascade do |t|
    t.integer "user_id"
    t.integer "supplier_id"
    t.integer "buyer_id"
    t.integer "do_id"
    t.integer "po_id"
    t.integer "status"
    t.text "payment_text"
    t.hstore "razorpay_json"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payment_links", force: :cascade do |t|
    t.integer "delivery_order_id", default: [], array: true
    t.string "razorpay_order_id"
    t.string "razorpay_link"
    t.datetime "expire_on"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.bigserial "invoice_number", null: false
    t.decimal "amount", precision: 10, scale: 2, default: "0.0", null: false
    t.bigint "receiver_id", null: false
    t.string "payment_mode", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_aliases", force: :cascade do |t|
    t.bigint "product_id"
    t.string "alias_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id", "alias_name"], name: "index_product_aliases_on_product_id_and_alias_name", unique: true
    t.index ["product_id"], name: "index_product_aliases_on_product_id"
  end

  create_table "product_categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_pricings", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.bigint "business_id"
    t.bigint "consumer_location_id"
    t.index ["business_id", "consumer_location_id"], name: "index_product_pricings_on_business_id_and_consumer_location_id"
    t.index ["business_id"], name: "index_product_pricings_on_business_id"
    t.index ["consumer_location_id"], name: "index_product_pricings_on_consumer_location_id"
    t.index ["product_id"], name: "index_product_pricings_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "barcode"
    t.string "name", null: false
    t.string "image"
    t.decimal "weight", null: false
    t.integer "shelf_life"
    t.decimal "default_price", precision: 10, scale: 2, null: false
    t.boolean "delivery_allowed", default: true
    t.boolean "returns_allowed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "business_id"
    t.string "weight_unit", default: "1", null: false
    t.string "sku"
    t.text "description"
    t.string "unit_type"
    t.integer "quantity", default: 1
    t.bigint "brand_id"
    t.boolean "active", default: true
    t.string "shelf_life_period"
    t.integer "product_category_id"
    t.float "cgst", default: 0.0
    t.float "sgst", default: 0.0
    t.integer "sync_status"
    t.string "guid"
    t.string "remarks"
    t.boolean "is_modified", default: false
    t.index ["barcode"], name: "index_products_on_barcode"
    t.index ["brand_id"], name: "index_products_on_brand_id"
    t.index ["business_id"], name: "index_products_on_business_id"
  end

  create_table "razor_payments", force: :cascade do |t|
    t.integer "delivery_order_id", default: [], array: true
    t.string "razorpay_payment_id"
    t.string "invoice_id"
    t.hstore "razorpay_json"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.hstore "transfer_json"
    t.string "payment_link"
    t.datetime "paid_on"
    t.datetime "last_reminder_sent"
    t.index ["razorpay_payment_id", "status"], name: "index_razor_payments_on_razorpay_payment_id_and_status", unique: true
  end

# Could not dump table "return_order_items" because of following StandardError
#   Unknown type 'ro_item_status' for column 'status'

# Could not dump table "return_orders" because of following StandardError
#   Unknown type 'ro_status' for column 'status'

# Could not dump table "return_reasons" because of following StandardError
#   Unknown type 'return_reason_category' for column 'category'

  create_table "return_requests", force: :cascade do |t|
    t.bigint "business_id"
    t.bigint "location_id"
    t.bigint "user_id"
    t.bigint "supplier_id"
    t.text "supplier_remark"
    t.text "customer_remark"
    t.boolean "is_return_accepted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status"
    t.datetime "completed_at"
    t.index ["business_id"], name: "index_return_requests_on_business_id"
    t.index ["location_id"], name: "index_return_requests_on_location_id"
    t.index ["supplier_id"], name: "index_return_requests_on_supplier_id"
    t.index ["user_id"], name: "index_return_requests_on_user_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "name"
    t.integer "age"
    t.integer "rollno"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tally_sales_voucher_updates", force: :cascade do |t|
    t.bigint "delivery_order_id"
    t.hstore "voucher_updation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["delivery_order_id"], name: "index_tally_sales_voucher_updates_on_delivery_order_id"
  end

  create_table "tenants", force: :cascade do |t|
    t.string "subdomain", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subdomain"], name: "index_tenants_on_subdomain"
  end

  create_table "user_fcm_tokens", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "business_id"
    t.string "devise_id"
    t.string "fcm_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_locations", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_user_locations_on_location_id"
    t.index ["user_id"], name: "index_user_locations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest", default: "", null: false
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "jtis"
    t.bigint "business_id"
    t.string "first_name"
    t.string "last_name"
    t.string "contact_number"
    t.string "profile_image"
    t.integer "invited_by_id"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.string "invitation_token_digest", default: "", null: false
    t.boolean "active", default: true
    t.hstore "permissions", default: {}
    t.string "country_code", default: "+91"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token", default: "", null: false
    t.datetime "reset_password_accepted_at"
    t.boolean "invitation_accepted", default: false
    t.integer "cart_items_count", default: 0, null: false
    t.boolean "is_otp", default: false
    t.boolean "otp_verified", default: false
    t.bigint "otp"
    t.index ["business_id"], name: "index_users_on_business_id"
    t.index ["country_code", "contact_number"], name: "index_users_on_country_code_and_contact_number", unique: true
  end

  create_table "users_businesses", force: :cascade do |t|
    t.integer "assigned_user_id"
    t.integer "assigned_business_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "business_locations", "users"
  add_foreign_key "business_preferences", "businesses"
  add_foreign_key "delivery_order_histories", "delivery_orders"
  add_foreign_key "delivery_orders", "order_requests"
  add_foreign_key "indent_products_lists", "indents"
  add_foreign_key "indent_products_lists", "products"
  add_foreign_key "indents", "businesses"
  add_foreign_key "indents", "locations"
  add_foreign_key "indents", "users"
  add_foreign_key "intra_transfers", "businesses"
  add_foreign_key "intra_transfers", "products"
  add_foreign_key "order_histories", "delivery_orders"
  add_foreign_key "order_request_histories", "order_requests"
  add_foreign_key "order_request_lists", "order_requests"
  add_foreign_key "order_request_lists", "products"
  add_foreign_key "order_request_template_lists", "order_request_templates"
  add_foreign_key "order_request_template_lists", "products"
  add_foreign_key "order_request_templates", "businesses"
  add_foreign_key "order_request_templates", "locations"
  add_foreign_key "order_request_templates", "users"
  add_foreign_key "order_requests", "businesses"
  add_foreign_key "order_requests", "locations"
  add_foreign_key "order_requests", "users"
  add_foreign_key "product_aliases", "products"
  add_foreign_key "return_requests", "businesses"
  add_foreign_key "return_requests", "locations"
  add_foreign_key "return_requests", "users"
  add_foreign_key "tally_sales_voucher_updates", "delivery_orders"
  add_foreign_key "user_locations", "locations"
  add_foreign_key "user_locations", "users"
  add_foreign_key "users", "businesses"
end
