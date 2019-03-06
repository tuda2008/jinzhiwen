class CreateUserDevices < ActiveRecord::Migration[5.2]
  def change
    create_table :user_devices do |t|
      t.integer :user_id, null: false
      t.integer :device_id, null: false
      t.integer :ownership, limit: 4, default: UserDevice::OWNERSHIP[:user], null: false, comments: "关联关系：超管、管理员、普通用户" 
      t.string  :encrypted_password, limit: 255, default: "", comments: "用户设定的密码" 
    end

    add_index :user_devices, :user_id
    add_index :user_devices, :device_id
    add_index :user_devices, [:user_id, :device_id]
    add_index :user_devices, [:user_id, :device_id, :ownership], unique: true
  end
end