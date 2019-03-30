# == Schema Information
#
# Table name: device_uuids
#
#  id            :bigint(8)        not null, primary key
#  supplier_id   :integer          not null
#  category_id   :integer          not null
#  product_id    :integer          not null
#  uuid          :string(12)       not null
#  auth_password :string(6)        not null
#  code          :string(10)       not null
#  protocol      :bigint(8)        default(1), not null
#  active        :boolean          default(FALSE)
#  actived_at    :datetime
#  created_at    :datetime         not null
#

class DeviceUuid < ApplicationRecord
  PROTOCOLS = { ble: 1, wifi: 2 }
  PROTOCOL_COLLECTION = [["蓝牙", 1], ["Wifi", 2]]
  PROTOCOL_HASH = { 1 => "蓝牙", 2 => "Wifi" }

  belongs_to :supplier
  belongs_to :category
  belongs_to :product

  has_one :device, foreign_key: 'uuid'

  validates :supplier_id, :category_id, :product_id, :protocol, :uuid, :auth_password, :code, presence: true
  validates :uuid, uniqueness: { case_sensitive: false }, length: { in: 8..12 }
  validates :auth_password, length: { in: 4..6 }
  validates :code, length: { in: 4..8 }

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }

  def self.new_and_init
    du = DeviceUuid.new
    du.uuid = SecureRandom.hex[0..7]
    du.auth_password = SecureRandom.hex[0..3]
    du.code = SecureRandom.hex[0..3]
    return du
  end
end