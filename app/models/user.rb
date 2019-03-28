# == Schema Information
#
# Table name: users
#
#  id          :bigint(8)        not null, primary key
#  provider    :integer          default(1), not null
#  nickname    :string(255)
#  mobile      :string(255)
#  avatar_url  :string(255)
#  open_id     :string(255)      not null
#  session_key :string(255)
#  country     :string(255)
#  province    :string(255)
#  city        :string(255)
#  gender      :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class User < ApplicationRecord
  PROVIDERS = { wechat: 1, qq: 2 }
  PROVIDER_COLLECTION = [["wechat", 1], ["qq", 2]]
  PROVIDER_HASH = { 1 => "wechat", 2 => "qq" }

  GENDERS = { "未知": 0, "男": 1, "女": 2 }
  GENDER_COLLECTION = [["未知", 0], ["男", 1], ["女", 2]]
  GENDER_HASH = { 0 => "未知", 1 => "男", 2 => "女" }

  has_many :user_devices, :dependent => :destroy
  has_many :devices, :through => :user_devices

  has_many :messages

  scope :male, -> { where(gender: 1) }
  scope :female, -> { where(gender: 2) }

  def name
    self.nickname
  end

  def self.find_or_create_by_wechat(code)
    return nil unless code
    wechat_request_url = "https://api.weixin.qq.com/sns/jscode2session?appid=#{ENV["WECHAT_APP_ID"]}&secret=#{ENV["WECHAT_APP_SECRET"]}&js_code=#{code}&grant_type=authorization_code"
    response = HTTParty.post(wechat_request_url)
    begin
      open_id = JSON.load(response.body)["openid"]
      session_key = JSON.load(response.body)["session_key"]
    rescue => e
      p e.message
    end
    return nil unless open_id
    entity = self.find_by(open_id: open_id)
    unless entity
      entity = self.create(open_id: open_id, session_key: session_key, gender: 0)
    else
      entity.update_attribute(:session_key, session_key) if session_key
    end
    return entity
  end

end