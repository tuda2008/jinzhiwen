# == Schema Information
#
# Table name: user_devices
#
#  id                 :bigint(8)        not null, primary key
#  user_id            :integer          not null
#  device_id          :integer          not null
#  ownership          :integer          default(1), not null
#  encrypted_password :string(255)      default("")
#

class UserDevice < ApplicationRecord
  OWNERSHIP = { user: 1, admin: 2, super_admin: 3 }

  belongs_to :user
  belongs_to :device

  validates :user_id, :device_id, :encrypted_password, presence: true
  validates :user_id, :uniqueness => { :scope => :device_id }
  validates :encrypted_password, length: { allow_nil: true, minimum: 4, maximum: 6 }
end
