class Api::V1::DevicesController < ApplicationController
  before_action :find_user
  before_action :find_device, only: [:show, :unbind, :cmd]

  def index
    @devices = Device.joins(:user_devices).where(:user_devices => { user_id: @user.id }).page(params[:page]).per(10)
  end

  def show
    
  end

  def bind
  	device_uuid = DeviceUuid.where(:uuid => params[:uuid], :auth_password => params[:password]).first
    if device_uuid
      Device.transaction do
        device = Device.find_or_create(:uuid => device_uuid.id, status_id => 1)
        UserDevice.create(:user => @user, :device => device)
      end
    else

    end
  end

  def unbind
    user_device = UserDevice.where(:user_id => @user.id, :device_id => @device.id).first
    user_device.destroy if user_device

  end

  def cmd

  end

  private
    def find_user
      @user = User.find_by(open_id: params[:openid])
    end

    def find_device
      @device = Device.joins(:user_devices).where(:user_devices => { user_id: @user.id }, :devices => { id: params[:device_id] }).first
    end
end