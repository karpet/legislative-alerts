class InitSchema < ActiveRecord::Migration
  def up
    
    create_table "alerts", force: :cascade do |t|
      t.string   "uuid"
      t.string   "name"
      t.string   "description"
      t.text     "query"
      t.integer  "user_id"
      t.datetime "created_at",  null: false
      t.datetime "updated_at",  null: false
      t.index ["uuid"], name: "index_alerts_on_uuid", unique: true
    end
    
    create_table "identities", force: :cascade do |t|
      t.integer  "user_id"
      t.string   "provider"
      t.string   "accesstoken"
      t.string   "uid"
      t.string   "name"
      t.string   "email"
      t.string   "nickname"
      t.string   "image"
      t.string   "phone"
      t.string   "urls"
      t.datetime "created_at",   null: false
      t.datetime "updated_at",   null: false
      t.string   "secrettoken"
      t.string   "refreshtoken"
      t.index ["user_id"], name: "index_identities_on_user_id"
    end
    
    create_table "users", force: :cascade do |t|
      t.string   "email",                  default: ""
      t.string   "encrypted_password",     default: "", null: false
      t.string   "reset_password_token"
      t.datetime "reset_password_sent_at"
      t.datetime "remember_created_at"
      t.integer  "sign_in_count",          default: 0,  null: false
      t.datetime "current_sign_in_at"
      t.datetime "last_sign_in_at"
      t.string   "current_sign_in_ip"
      t.string   "last_sign_in_ip"
      t.datetime "created_at",                          null: false
      t.datetime "updated_at",                          null: false
      t.integer  "role"
      t.index ["email"], name: "index_users_on_email"
      t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    end
    
  end

  def down
    raise ActiveRecord::IrreversibleMigration, "The initial migration is not revertable"
  end
end
