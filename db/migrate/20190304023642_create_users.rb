class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.integer  :provider, null: false, default: User::PROVIDERS[:wechat]
      t.string   :nickname
      t.string   :mobile
      t.string   :avatar_url
      t.string   :open_id, null: false
      t.string   :session_key
      t.string   :country
      t.string   :province
      t.string   :city
      t.integer  :gender, default: User::GENDERS["未知"]

      t.timestamps
    end

    add_index :users, :provider
    add_index :users, :nickname
    add_index :users, :open_id
    add_index :users, :session_key
    add_index :users, :province
    add_index :users, :city
    add_index :users, :gender
    add_index :users, [:provider, :open_id], unique: true
  end
end