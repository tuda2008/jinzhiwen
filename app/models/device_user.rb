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
  belongs_to :device
end