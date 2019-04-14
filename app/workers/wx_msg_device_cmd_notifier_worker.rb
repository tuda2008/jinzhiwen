class WxMsgDeviceCmdNotifierWorker
  include Sidekiq::Worker

  def perform(users, content, type)
  	content = "亲，" + content
  	if type == "text"
  	  content = "亲，" + content + "
  	  " + '<a href="#{ENV["WEB_URL"]}" data-miniprogram-appid="#{ENV["WECHAT_APP_ID"]}" data-miniprogram-path="pages/devices/index/index">立即进入</a>'
  	end
  	users.each do |user|
  	  User.send_msg(user.open_id, content, type)
    end
  end
end