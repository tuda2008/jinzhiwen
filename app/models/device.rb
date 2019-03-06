# == Schema Information
#
# Table name: devices
#
#  id         :bigint(8)        not null, primary key
#  uuid       :integer          not null
#  status_id  :integer          not null
#  alias      :string(50)       default("门锁"), not null
#  wifi_mac   :string(20)
#  monitor_sn :string(255)
#  port       :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Device < ApplicationRecord
  has_many :user_devices, :dependent => :destroy
  has_many :users, :through => :user_devices

  has_many :messages
end
