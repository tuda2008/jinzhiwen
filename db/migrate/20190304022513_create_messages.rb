class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.integer  :user_id, null: false
      t.integer  :device_id, null: false, comments: "设备id"
      t.string   :oper_cmd, limit: 20, null: false, comments: "操作指令"
      t.string   :oper_username, limit: 20, comments: "操作设备的用户名"
      t.string   :device_type, null: false, default: "lock", comments: "设备类型"

      t.string   :avatar_path,      limit: 255, comments: "封面地址"
	    t.string   :gif_path,         limit: 255, comments: "动图地址"
	    t.text     :ori_picture_paths, limit: 500, comments: "原图地址"
	    t.integer  :lock_num,         limit: 4, comments: "对应锁的指纹、密码、卡号"
	    t.integer  :lock_type,        limit: 4, comments: "锁的类型，对应指纹、密码、卡"

      t.boolean  :is_deleted, null: false, default: false
      
      t.datetime :created_at, null: false
    end
    
    add_index :messages, :oper_cmd
    add_index :messages, :oper_username
    add_index :messages, :device_type
    add_index :messages, :is_deleted
    add_index :messages, :created_at
    add_index :messages, [:is_deleted, :created_at]
    add_index :messages, [:user_id, :is_deleted]
    add_index :messages, [:user_id, :is_deleted, :created_at]
    add_index :messages, [:user_id, :device_id, :is_deleted]
    add_index :messages, [:user_id, :device_id, :is_deleted, :created_at], name: "messages_user_device_created_at"
  end
end