class CreateDevices < ActiveRecord::Migration[5.2]
  def change
    create_table :devices do |t|
      t.integer :uuid, null: false, comments: "关联device_uuids_id" 
      t.integer :status_id, null: false, comments: "关联device_statuses_id" 
      t.string  :alias, limit: 50, default: "门锁",  null: false

      t.string  :wifi_mac, limit: 20, comments: "该设备绑定的网关mac"

      t.string  :monitor_sn, limit: 255, comments: "该设备绑定的监控sn"
      t.integer :port,       limit: 6, comments: "该设备绑定的网关port"

      t.timestamps
    end

    add_index :devices, :uuid
    add_index :devices, :status_id
    add_index :devices, :alias
    add_index :devices, :wifi_mac
    add_index :devices, :monitor_sn
    add_index :devices, :port
  end
end