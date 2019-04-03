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

ActiveRecord::Schema.define(version: 2019_04_03_080634) do

  create_table "active_admin_comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
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
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "app_versions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "code", default: 1, null: false
    t.string "name", null: false
    t.integer "mobile_system", default: 3, null: false
    t.text "content", null: false
    t.datetime "created_at"
    t.index ["code", "mobile_system"], name: "index_app_versions_on_code_and_mobile_system", unique: true
    t.index ["code"], name: "index_app_versions_on_code"
    t.index ["mobile_system"], name: "index_app_versions_on_mobile_system"
  end

  create_table "categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title", null: false
    t.string "intro", default: ""
    t.string "images"
    t.boolean "visible", default: false
    t.index ["intro"], name: "index_categories_on_intro"
    t.index ["title", "visible"], name: "index_categories_on_title_and_visible", unique: true
    t.index ["title"], name: "index_categories_on_title", unique: true
    t.index ["visible"], name: "index_categories_on_visible"
  end

  create_table "category_products", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "category_id", null: false
    t.integer "product_id", null: false
    t.index ["category_id", "product_id"], name: "index_category_products_on_category_id_and_product_id", unique: true
    t.index ["category_id"], name: "index_category_products_on_category_id"
    t.index ["product_id"], name: "index_category_products_on_product_id"
  end

  create_table "device_statuses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", limit: 50, default: "未绑定", null: false
    t.integer "category_id", null: false
    t.boolean "enable", default: true
    t.index ["category_id", "enable"], name: "index_device_statuses_on_category_id_and_enable"
    t.index ["category_id"], name: "index_device_statuses_on_category_id"
    t.index ["enable"], name: "index_device_statuses_on_enable"
    t.index ["name", "category_id", "enable"], name: "device_statuses_name_cate_enable", unique: true
    t.index ["name"], name: "index_device_statuses_on_name"
  end

  create_table "device_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "device_id", null: false
    t.integer "device_type", null: false
    t.integer "device_num", null: false
    t.string "username", limit: 40, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["device_id", "device_type"], name: "index_device_users_on_device_id_and_device_type"
    t.index ["device_id"], name: "index_device_users_on_device_id"
    t.index ["device_type"], name: "index_device_users_on_device_type"
  end

  create_table "device_uuids", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "supplier_id", null: false
    t.integer "category_id", null: false
    t.integer "product_id", null: false
    t.string "uuid", limit: 12, null: false
    t.string "auth_password", limit: 6, null: false
    t.string "code", limit: 10, null: false
    t.bigint "protocol", default: 1, null: false
    t.boolean "active", default: false
    t.datetime "actived_at"
    t.datetime "created_at", null: false
    t.index ["active"], name: "index_device_uuids_on_active"
    t.index ["actived_at"], name: "index_device_uuids_on_actived_at"
    t.index ["category_id"], name: "index_device_uuids_on_category_id"
    t.index ["created_at"], name: "index_device_uuids_on_created_at"
    t.index ["product_id"], name: "index_device_uuids_on_product_id"
    t.index ["protocol"], name: "index_device_uuids_on_protocol"
    t.index ["supplier_id", "category_id", "product_id"], name: "device_uuids_supplier_category_product"
    t.index ["supplier_id"], name: "index_device_uuids_on_supplier_id"
    t.index ["uuid", "auth_password"], name: "index_device_uuids_on_uuid_and_auth_password"
    t.index ["uuid"], name: "index_device_uuids_on_uuid", unique: true
  end

  create_table "devices", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "uuid", null: false
    t.integer "status_id", null: false
    t.string "alias", limit: 50, default: "门锁", null: false
    t.string "wifi_mac", limit: 20
    t.string "monitor_sn"
    t.bigint "port"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alias"], name: "index_devices_on_alias"
    t.index ["monitor_sn"], name: "index_devices_on_monitor_sn"
    t.index ["port"], name: "index_devices_on_port"
    t.index ["status_id"], name: "index_devices_on_status_id"
    t.index ["uuid"], name: "index_devices_on_uuid"
    t.index ["wifi_mac"], name: "index_devices_on_wifi_mac"
  end

  create_table "invitations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "device_id", null: false
    t.string "invitation_token", null: false
    t.integer "invitation_limit", default: 5, null: false
    t.datetime "invitation_expired_at"
    t.datetime "invitation_accepted_at"
    t.datetime "invitation_created_at"
    t.index ["device_id"], name: "index_invitations_on_device_id"
    t.index ["invitation_token"], name: "index_invitations_on_invitation_token", unique: true
    t.index ["user_id", "device_id"], name: "index_invitations_on_user_id_and_device_id"
    t.index ["user_id"], name: "index_invitations_on_user_id"
  end

  create_table "messages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "device_id", null: false
    t.string "oper_cmd", limit: 20, null: false
    t.string "oper_username", limit: 20
    t.string "device_type", default: "lock", null: false
    t.string "avatar_path"
    t.string "gif_path"
    t.text "ori_picture_paths"
    t.integer "lock_num"
    t.integer "lock_type"
    t.boolean "is_deleted", default: false, null: false
    t.datetime "created_at", null: false
    t.index ["created_at"], name: "index_messages_on_created_at"
    t.index ["device_type"], name: "index_messages_on_device_type"
    t.index ["is_deleted", "created_at"], name: "index_messages_on_is_deleted_and_created_at"
    t.index ["is_deleted"], name: "index_messages_on_is_deleted"
    t.index ["oper_cmd"], name: "index_messages_on_oper_cmd"
    t.index ["oper_username"], name: "index_messages_on_oper_username"
    t.index ["user_id", "device_id", "is_deleted", "created_at"], name: "messages_user_device_created_at"
    t.index ["user_id", "device_id", "is_deleted"], name: "index_messages_on_user_id_and_device_id_and_is_deleted"
    t.index ["user_id", "is_deleted", "created_at"], name: "index_messages_on_user_id_and_is_deleted_and_created_at"
    t.index ["user_id", "is_deleted"], name: "index_messages_on_user_id_and_is_deleted"
  end

  create_table "products", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title", null: false
    t.string "intro", default: ""
    t.string "images"
    t.boolean "visible", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["intro"], name: "index_products_on_intro"
    t.index ["title", "visible"], name: "index_products_on_title_and_visible", unique: true
    t.index ["title"], name: "index_products_on_title", unique: true
    t.index ["visible"], name: "index_products_on_visible"
  end

  create_table "redactor2_assets", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "data_file_name", null: false
    t.string "data_content_type"
    t.integer "data_file_size"
    t.integer "assetable_id"
    t.string "assetable_type", limit: 30
    t.string "type", limit: 30
    t.integer "width"
    t.integer "height"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["assetable_type", "assetable_id"], name: "idx_redactor2_assetable"
    t.index ["assetable_type", "type", "assetable_id"], name: "idx_redactor2_assetable_type"
  end

  create_table "supplier_categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "supplier_id", null: false
    t.integer "category_id", null: false
    t.index ["category_id"], name: "index_supplier_categories_on_category_id"
    t.index ["supplier_id", "category_id"], name: "index_supplier_categories_on_supplier_id_and_category_id", unique: true
    t.index ["supplier_id"], name: "index_supplier_categories_on_supplier_id"
  end

  create_table "supplier_products", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "supplier_id", null: false
    t.integer "product_id", null: false
    t.index ["product_id"], name: "index_supplier_products_on_product_id"
    t.index ["supplier_id", "product_id"], name: "index_supplier_products_on_supplier_id_and_product_id", unique: true
    t.index ["supplier_id"], name: "index_supplier_products_on_supplier_id"
  end

  create_table "suppliers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", limit: 120, null: false
    t.string "abbr", limit: 60, null: false
    t.string "intro", default: ""
    t.string "address", default: ""
    t.string "tel", default: ""
    t.string "images"
    t.boolean "visible", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["abbr"], name: "index_suppliers_on_abbr"
    t.index ["address"], name: "index_suppliers_on_address"
    t.index ["intro"], name: "index_suppliers_on_intro"
    t.index ["name", "visible"], name: "index_suppliers_on_name_and_visible", unique: true
    t.index ["name"], name: "index_suppliers_on_name", unique: true
    t.index ["tel"], name: "index_suppliers_on_tel"
    t.index ["visible"], name: "index_suppliers_on_visible"
  end

  create_table "user_devices", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "device_id", null: false
    t.integer "ownership", default: 1, null: false
    t.string "encrypted_password", default: ""
    t.index ["device_id"], name: "index_user_devices_on_device_id"
    t.index ["user_id", "device_id", "ownership"], name: "index_user_devices_on_user_id_and_device_id_and_ownership", unique: true
    t.index ["user_id", "device_id"], name: "index_user_devices_on_user_id_and_device_id"
    t.index ["user_id"], name: "index_user_devices_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "provider", default: 1, null: false
    t.string "nickname"
    t.string "mobile"
    t.string "avatar_url"
    t.string "open_id", null: false
    t.string "session_key"
    t.string "country"
    t.string "province"
    t.string "city"
    t.integer "gender", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city"], name: "index_users_on_city"
    t.index ["gender"], name: "index_users_on_gender"
    t.index ["nickname"], name: "index_users_on_nickname"
    t.index ["open_id"], name: "index_users_on_open_id"
    t.index ["provider", "open_id"], name: "index_users_on_provider_and_open_id", unique: true
    t.index ["provider"], name: "index_users_on_provider"
    t.index ["province"], name: "index_users_on_province"
    t.index ["session_key"], name: "index_users_on_session_key"
  end

end
