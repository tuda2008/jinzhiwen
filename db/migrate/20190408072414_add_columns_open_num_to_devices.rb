class AddColumnsOpenNumToDevices < ActiveRecord::Migration[5.2]
  def change
  	add_column :devices, :open_num, :integer, default: 0, comments: "开门次数"
  	add_column :devices, :low_qoe, :boolean, default: false, comments: "低电量"
    add_index  :devices, :open_num
    add_index  :devices, :low_qoe
  end
end