# == Schema Information
#
# Table name: messages
#
#  id                :bigint(8)        not null, primary key
#  user_id           :integer          not null
#  device_id         :integer          not null
#  oper_cmd          :string(20)       not null
#  oper_username     :string(20)
#  device_type       :string(255)      default("lock"), not null
#  avatar_path       :string(255)
#  gif_path          :string(255)
#  ori_picture_paths :text(65535)
#  lock_num          :integer
#  lock_type         :integer
#  is_deleted        :boolean          default(FALSE), not null
#  created_at        :datetime         not null
#

class Message < ApplicationRecord
  belongs_to :user
  belongs_to :device

  scope :visible, -> { where(is_deleted: false) }
  scope :invisible, -> { where(is_deleted: true) }
  scope :smart_lock, -> { where(device_type: "lock") }
end
