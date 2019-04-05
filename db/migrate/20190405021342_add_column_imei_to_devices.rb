class AddColumnImeiToDevices < ActiveRecord::Migration[5.2]
  def change
  	add_column :devices, :imei, :string, limit: 40, default: "", comments: "终端串码"
  	add_index  :devices, :imei
  end
end