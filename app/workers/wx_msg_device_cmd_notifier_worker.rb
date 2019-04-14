class WxMsgDeviceCmdNotifierWorker
  include Sidekiq::Worker

  def perform(users, content, type)
  	users.each do |user|
  	  User.send_msg(user.open_id, content, type)
    end
  end
end