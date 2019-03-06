class CreateDeviceStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :device_statuses do |t|
      t.string  :name, limit: 50, default: "未绑定",  null: false, comments: "设备状态：未绑定、已绑定" 
      t.integer :category_id, null: false

      t.boolean :enable, default: true, comments: "是否可用"
    end

    add_index :device_statuses, :name
    add_index :device_statuses, :category_id
    add_index :device_statuses, :enable
    add_index :device_statuses, [:category_id, :enable]
    add_index :device_statuses, [:name, :category_id, :enable], name: "device_statuses_name_cate_enable", unique: true
  end
end