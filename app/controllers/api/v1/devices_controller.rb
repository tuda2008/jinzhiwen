class Api::V1::DevicesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :find_user
  before_action :find_device, only: [:show, :unbind, :cmd, :rename, :users]

  def index
    page = params[:page].blank? ? 1 : params[:page].to_i
    datas = []
    @devices = Device.joins(:user_devices).includes(:device_status, :device_uuid).where(:user_devices => { user_id: @user.id }).reload.page(page).per(10)
    @devices.each do |dv|
      datas << { id: dv.id, status: dv.device_status.name,
                 uuid: dv.device_uuid.uuid, name: dv.name,
                 protocol: dv.device_uuid.protocol, code: dv.device_uuid.code}
    end
    respond_to do |format|
      format.json do
        render json: { status: 1, message: "ok", data: datas, total_pages: @devices.total_pages, current_page: page }
      end
    end
  end

  def show
    respond_to do |format|
      format.json do
        if @device
          data = { id: @device.id, name: @device.name, product: @device.device_uuid.product.title, uuid: @device.device_uuid.uuid, code: @device.device_uuid.code, created_at: @device.device_uuid.created_at.strftime('%Y-%m-%d') }
          render json: { status: 1, message: "ok", data: data } 
        else
          render json: { status: 0, message: "no recored yet" } 
        end
      end
    end
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
              device = Device.where(:uuid => device_uuid.id).first
              unless device
                device = Device.create(:uuid => device_uuid.id, :status_id => 1)
              end
              device_uuid.update_attribute(:active, true)
              user_device = UserDevice.where(:device => device).first
              unless user_device
                UserDevice.create(:user => @user, :device => device, :ownership => UserDevice::OWNERSHIP[:super_admin])
              else
                ud = UserDevice.where(:user_id => @user.id, :device_id => device.id).first
                unless ud
                  UserDevice.create(:user_id => @user.id, :device_id => device.id)
                end
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
          user_device = UserDevice.where(:user => @user, :device => @device).first
          if user_device.is_admin?
            @device.destroy
          else
            user_device.destroy
            #render json: { status: 0, message: "亲，只有管理员才能解绑哦" } and return
          end
          render json: { status: 1, message: "ok" }
        else
          render json: { status: 0, message: "设备不存在" }
        end
      end
    end
  end

  def rename
    respond_to do |format|
      format.json do
        if @device
          @device.update_attribute(:alias, params[:name].strip)
          render json: { status: 1, message: "ok", data: { name: params[:name].strip } } 
        else
          render json: { status: 0, message: "no recored yet" } 
        end
      end
    end
  end

  def cmd
    msg = Message.new(user_id: @user.id, device_id: @device.id, oper_cmd: params[:lock_cmd], lock_type: params[:lock_type], lock_num: params[:lock_num])
    if params[:lock_cmd].include?("remove")
      du = DeviceUser.where(device_id: @device.id, device_type: params[:lock_type], device_num: params[:lock_num]).first
      du.destroy if du
    elsif params[:lock_cmd].include?("reg")
      username = params[:user_name].blank? ? ("##{params[:lock_num]}" + DeviceUser::TYPENAME[params[:lock_type]]) : params[:user_name].strip()
      du = DeviceUser.new(device_id: @device.id, device_type: params[:lock_type], device_num: params[:lock_num], username: username)
      du.save if du.valid?
    elsif params[:lock_cmd]=="init"
      Device.transaction do
        DeviceUuid.where(id: @device.uuid).update_all(active: false)
        @device.destroy
      end
    end
    respond_to do |format|
      format.json do
        if msg.valid?
          msg.save
          render json: { status: 1, message: "ok" } 
        else
          render json: { status: 0, message: msg.errors.full_messages.to_sentence } 
        end
      end
    end
  end

  def users
    page = params[:page].blank? ? 1 : params[:page].to_i
    users = DeviceUser.where(device_id: @device.id, device_type: params[:lock_type]).reload.page(page).per(10)
    datas = []
    users.each do |du|
      datas << { id: du.id, username: du.username, device_num: du.device_num }
    end
    respond_to do |format|
      format.json do
        render json: { status: 1, message: "ok", data: datas, total_pages: users.total_pages, current_page: page }
      end
    end
  end

  def edit_user
    du = DeviceUser.where(id: params[:id], device_num: params[:num]).first
    respond_to do |format|
      format.json do
        if du && du.update_attribute(:username, params[:name].strip)
          render json: { status: 1, message: "ok" }
        else
          render json: { status: 0, message: "error" }
        end
      end
    end
  end

  private
    def find_user
      @user = User.find_by(open_id: params[:openid])
    end

    def find_device
      @device = Device.joins(:user_devices).where(:user_devices => { user_id: @user.id }, :devices => { id: params[:device_id] }).first
    end
end