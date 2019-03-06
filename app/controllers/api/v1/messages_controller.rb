class Api::V1::MessagesController < ApplicationController
  before_action :find_user

  def index
  	if params[:device_id]
  	  @messages = Message.where(user_id: @user.id, device_id: params[:device_id]).page(params[:page]).per(10)
  	else
  	  @messages = Message.where(user_id: @user.id).page(params[:page]).per(10)
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