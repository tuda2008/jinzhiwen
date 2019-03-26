# == Schema Information
#
# Table name: device_users
#
#  id          :bigint(8)        not null, primary key
#  device_id   :integer          not null
#  device_type :integer          not null
#  device_num  :integer          not null
#  username    :string(40)       not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class DeviceUser < ApplicationRecord
  LOCKTYPES = { finger: 1, password: 2, card: 3 }
  TYPENAME = { "1" => "指纹", "2" => "密码", "3" => "IC卡" }

  belongs_to :device

  validates :device_id, :uniqueness => { :scope => [:device_type, :device_num] }
  validates :username, length: { in: 2..20 }
end