class CreateDeviceUuids < ActiveRecord::Migration[5.2]
  def change
    create_table :device_uuids do |t|
      t.integer :supplier_id, null: false
      t.integer :category_id, null: false
      t.integer :product_id, null: false

      t.string :uuid, limit: 12, null: false, comments: "设备uuid，用于二维码验证"
      t.string :auth_password, limit: 6, null: false, comments: "设备验证码，用于二维码验证"
      t.string :code, limit: 10, null: false, comments: "设备通讯码，用于设备通讯"
      t.integer :protocol, limit: 6, null: false, default: DeviceUuid::PROTOCOLS[:ble], comments: "设备通讯协议类型，蓝牙、4G等"

      t.boolean  :active, default: false, comments: "是否激活"

      t.datetime :actived_at
      t.datetime :created_at, null: false
    end

    add_index :device_uuids, :supplier_id
    add_index :device_uuids, :category_id
    add_index :device_uuids, :product_id
    add_index :device_uuids, :protocol
    add_index :device_uuids, :active
    add_index :device_uuids, :uuid, unique: true
    add_index :device_uuids, [:uuid, :auth_password]
    add_index :device_uuids, :actived_at
    add_index :device_uuids, :created_at
    add_index :device_uuids, [:supplier_id, :category_id, :product_id], name: :device_uuids_supplier_category_product
  end
end