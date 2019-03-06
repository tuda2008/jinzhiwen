# == Schema Information
#
# Table name: device_statuses
#
#  id          :bigint(8)        not null, primary key
#  name        :string(50)       default("未绑定"), not null
#  category_id :integer          not null
#  enable      :boolean          default(TRUE)
#

class DeviceStatus < ApplicationRecord
  belongs_to :category

  validates :name, :category_id, :enable, presence: true
  validates :name, uniqueness: { :scope => :category_id, case_sensitive: false }, length: { in: 2..10 }

  scope :enable, -> { where(enable: true) }
  scope :disable, -> { where(enable: false) }
end
