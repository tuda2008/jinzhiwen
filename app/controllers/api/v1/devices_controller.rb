class Api::V1::DevicesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :find_user
  before_action :find_device, only: [:show, :unbind, :cmd]

  def index
    page = params[:page].blank? ? 1 : params[:page].to_i
    datas = []
    @devices = Device.joins(:user_devices).includes(:device_status, :device_uuid).where(:user_devices => { user_id: @user.id }).page(page).per(10)
    @devices.each do |dv|
      datas << { id: dv.id, status: dv.device_status.name, uuid: dv.device_uuid.uuid, 
                 name: dv.alias.blank? ? dv.device_uuid.category.name : dv.alias,
                 protocol: dv.device_uuid.protocol, code: dv.device_uuid.code}
    end
    respond_to do |format|
      format.json do
        render json: { status: 1, message: "ok", data: datas, total_pages: @devices.total_pages, current_page: page }
      end
    end
  end

  def show
    
  end

  def bind
    # todo start
    result = params[:result]
    return if result.blank?
    result = result.split(",")
    return if result.length < 2
    # todo end
  	device_uuid = DeviceUuid.where(:uuid => result[0], :auth_password => result[1]).first
    respond_to do |format|
      format.json do
        if device_uuid
          unless device_uuid.active
            Device.transaction do 
              device = Device.find_or_create_by(:uuid => device_uuid.id, :status_id => 1)
              device_uuid.update_attribute(:active, true)
              user_device = UserDevice.where(:device => device).first
              unless user_device
                UserDevice.create(:user => @user, :device => device, :ownership => UserDevice::OWNERSHIP[:super_admin])
              else
                UserDevice.find_or_create(:user => @user, :device => device)
              end
            end
            render json: { status: 1, message: "ok", data: { device_num: UserDevice.where(user_id: @user.id).reload.count } }
          else
            render json: { status: 0, message: "二维码已被使用，请联系客服申请售后", data: { device_num: UserDevice.where(user_id: @user.id).count }  }
          end
        else
          render json: { status: 0, message: "二维码不存在，请联系客服申请售后", data: { device_num: UserDevice.where(user_id: @user.id).count }  }
        end
      end
    end
  end

  def unbind
    respond_to do |format|
      format.json do
        if @device
          DeviceUuid.where(uuid: @device.uuid).update_all(active: false)
          @device.destroy
          render json: { status: 1, message: "ok" }
        else
          render json: { status: 0, message: "设备不存在" }
        end
      end
    end
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