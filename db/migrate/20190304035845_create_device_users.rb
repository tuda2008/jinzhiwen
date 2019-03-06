class CreateDeviceUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :device_users do |t|
      t.integer  :device_id,   limit: 4,   null: false 
      t.integer  :device_type, limit: 4,   null: false, comments: "设备类型，指纹、密码、卡" 
      t.integer  :device_num,  limit: 4,   null: false, comments: "设备类型，指纹、密码、卡号"
      t.string   :username,    limit: 40,  null: false, comments: "备注用户名" 

      t.timestamps
    end

    add_index :device_users, :device_id
    add_index :device_users, :device_type
    add_index :device_users, [:device_id, :device_type]
  end
end