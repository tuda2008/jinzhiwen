class Api::V1::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def wechat_auth
  	user = User.find_or_create_by_wechat(params[:code])
    respond_to do |format|
      format.json do
        if user
          render json: { status: 1, message: "ok", data: { openid: user.open_id, device_num: UserDevice.where(user_id: user.id).count } }
        else
          render json: { status: 0, message: "授权失败" }
        end
      end
    end
  end

  def update_wechat_userinfo
  	user = User.find_by(open_id: params[:openid])
    respond_to do |format|
      format.json do
      	if user
      	  user.update_attributes({:country => params[:country], :province => params[:province], :city => params[:city],
      	  	:nickname => params[:nickName], :gender => params[:gender], :avatar_url => params[:avatarUrl]})
      	  render json: { status: 1, message: "ok" }
        else
          render json: { status: 0, message: "更新用户信息失败" }
        end
      end
    end
  end

  def info
  	user = User.find_by(open_id: params[:openid])
    respond_to do |format|
      format.json do
      	if user
      	  render json: { status: 1, message: "ok", 
      	  	data: {
              id: user.id,
              device_num: UserDevice.where(user_id: user.id).count,
      		    user: {
      		  	  nickName: user.nickname,
      	        avatarUrl: user.avatar_url,
      	        country: user.country,
      	        province: user.province,
      	        city: user.city,
      	        gender: user.gender
      	     }
      	    }
          } 
        else
          render json: { status: 0, message: "获取用户信息失败" }
        end
      end
    end
  end
end