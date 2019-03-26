class Api::V1::MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :find_user

  def index
    page = params[:page].blank? ? 1 : params[:page].to_i
    query_type = params[:query_type].blank? ? 1 : params[:query_type].to_i
    datas = []
  	if params[:device_id]
      if query_type == 1
        @messages = Message.visible.today.where(user_id: @user.id, device_id: params[:device_id]).includes(:device).page(params[:page]).per(10)
      elsif query_type == 2
        @messages = Message.visible.yesterday.where(user_id: @user.id, device_id: params[:device_id]).includes(:device).page(params[:page]).per(10)
      else
        @messages = Message.visible.last_week.where(user_id: @user.id, device_id: params[:device_id]).includes(:device).page(params[:page]).per(10)
      end
      @messages.each do |msg|
        datas << { id: msg.id, oper_cmd: msg.oper_cmd,
                   lock_num: msg.lock_num, lock_type: msg.lock_type,
                   device_name: msg.device.name,
                   created_at: query_type==3 ? msg.created_at.strftime('%m-%d %H:%M:%S') : msg.created_at.strftime('%H:%M:%S')}
      end
  	else
      if query_type == 1
        @messages = Message.visible.today.where(user_id: @user.id).page(params[:page]).per(10)
      elsif query_type == 2
        @messages = Message.visible.yesterday.where(user_id: @user.id).page(params[:page]).per(10)
      else
        @messages = Message.visible.last_week.where(user_id: @user.id).page(params[:page]).per(10)
      end
      @messages.each do |msg|
        datas << { id: msg.id, oper_cmd: Message::CMD_NAMES[msg.oper_cmd],
                   lock_num: msg.lock_num.blank? ? "" : msg.lock_num, lock_type: Message::TYPENAMES[msg.lock_type],
                   created_at: query_type==3 ? msg.created_at.strftime('%m-%d %H:%M:%S') : msg.created_at.strftime('%H:%M:%S')}
      end
  	end
    respond_to do |format|
      format.json do
        render json: { status: 1, message: "ok", data: datas, total_pages: @messages.total_pages, current_page: page }
      end
    end
  end

  def show
    @message = Message.where(id: params[:message_id]).first
  end

  private
    def find_user
      @user = User.find_by(open_id: params[:openid])
    end
end