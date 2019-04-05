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

  has_many :device_users, :dependent => :destroy
  has_many :messages, :dependent => :destroy

  belongs_to :device_uuid, -> { includes :category }, foreign_key: :uuid
  belongs_to :device_status, foreign_key: :status_id

  has_many :invitations, :dependent => :destroy
  has_many :user_invitors, :through => :invitations

  validates :alias, length: { in: 1..10 }

  def name
    self.alias.blank? ? self.device_uuid.category.title : self.alias
  end

  def is_admin?(user_id)
    ud = self.user_devices.where(user_id: user_id).first
    !ud.nil? && ud.is_admin?
  end

  def invitations_by_user(user_id)
    self.invitations.where(:invitations => { user_id: user_id })
  end

  def user_invitors_by_user(user_id)
    self.user_invitors.where(:invitations => { user_id: user_id })
  end

  def invitors
    User.joins(:user_devices).joins("inner join invitations on invitations.device_id=user_devices.device_id 
      inner join user_invitors on user_invitors.invitation_id=invitations.id")
    .select("users.id, users.nickname, users.avatar_url, invitations.user_id")
    .where(:user_devices => { device_id: self.id } )
  end

  def invitors_by_user(user_id)
    User.joins(:user_devices).joins("inner join invitations on invitations.device_id=user_devices.device_id 
      inner join user_invitors on user_invitors.invitation_id=invitations.id")
    .select("users.id, users.nickname, users.avatar_url, invitations.user_id")
    .where(:user_devices => { device_id: self.id, user_id: user_id } )
  end
end