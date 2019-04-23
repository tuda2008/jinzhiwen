class WxMsgInvitationNotifierWorker
  include Sidekiq::Worker

  def perform(user_ids, content, type)
    return if user_ids.empty?
  	content = "亲，" + content
  	if type == "text"
  	  content = content + "
  	  " + '<a href="#{ENV["WEB_URL"]}" data-miniprogram-appid="#{ENV["WECHAT_APP_ID"]}" data-miniprogram-path="pages/devices/index/index">立即进入</a>'
  	end
  	User.find(user_ids).each do |user|
  	  User.send_msg(user.open_id, content, type)
    end
  end
end