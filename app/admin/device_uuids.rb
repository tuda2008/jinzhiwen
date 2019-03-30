require 'rqrcode'
ActiveAdmin.register DeviceUuid do
  permit_params :supplier_id, :category_id, :product_id, :protocol, :uuid, :auth_password, :code, :total_num

  menu priority: 5, label: proc{ I18n.t("activerecord.models.device_uuid") }

  #index download_links: [:csv, :xml, :json, :pdf]

  filter :supplier
  filter :category
  filter :product
  filter :uuid
  filter :protocol, as: :select, collection: DeviceUuid::PROTOCOL_COLLECTION
  filter :active

  scope("全部A") { |du| du.all }
  scope("已激活Y") { |du| du.active }
  scope("未激活N") { |du| du.inactive }

  index do
    selectable_column
      id_column
      column :supplier_id do |du|
        du.supplier.name
      end
      column :category_id do |du|
        du.category.title
      end
      column :product_id do |du|
        du.product.title
      end
      column :uuid
      column :protocol do |du|
        DeviceUuid::PROTOCOL_HASH[du.protocol]
      end
      column :active
    actions
  end

  show do
    attributes_table do
      row :id
      row :supplier_id do |du|
        du.supplier.name
      end
      row :category_id do |du|
        du.category.title
      end
      row :product_id do |du|
        du.product.title
      end
      row :protocol do |du|
        DeviceUuid::PROTOCOL_HASH[du.protocol]
      end
      row :uuid
      row :auth_password
      row :code
      row :active
      row :qrcode do |du|
        render_qr_code("#{resource.uuid},#{resource.auth_password}")
      end
      row :actived_at
      row :created_at
    end
  end

  csv do
    column :supplier_id do |du|
      du.supplier.name
    end
    column :category_id do |du|
      du.category.title
    end
    column :product_id do |du|
      du.product.title
    end
    column :uuid
    column :qrcode do |du|
      qrcode = RQRCode::QRCode.new("#{du.uuid},#{du.auth_password}")
      png = qrcode.as_png(
          resize_gte_to: false,
          resize_exactly_to: false,
          fill: 'white',
          color: 'black',
          size: 120,
          border_modules: 4,
          module_px_size: 6,
          file: "#{Rails.root}/app/assets/images/qrcode/#{du.id}.png")
      image_url("/assets/qrcode/#{du.id}.png")
    end
    column :protocol do |du|
        DeviceUuid::PROTOCOL_HASH[du.protocol]
    end
    column :active do |du|
      du.active ? "已激活" : "未激活"
    end
    column :created_at do |du|
      du.created_at.strftime('%Y-%m-%d')
    end
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :supplier_id, :as => :select, :collection => Supplier.visible.pluck(:name, :id), prompt: "请选择"
      f.input :category_id, :as => :select, :collection => Category.visible.pluck(:title, :id), prompt: "请选择"
      f.input :product_id, :as => :select, :collection => Product.visible.pluck(:title, :id), prompt: "请选择"
      f.input :protocol, :as => :select, :collection => DeviceUuid::PROTOCOL_COLLECTION
      f.input :uuid, :hint => "设备唯一编号", :input_html => { :value => resource.uuid.present? ? resource.uuid : '', :readonly => true }
      f.input :auth_password, :as => :string, :hint => "设备验证码", :input_html => { :value => resource.auth_password.present? ? resource.auth_password : '', :readonly => true }
      f.input :code, :hint => "设备通讯码", :input_html => { :value => resource.code.present? ? resource.code : '', :readonly => true }
    end

    f.actions
  end

  collection_action :new_uuid, :method => :post do
    uuid = SecureRandom.hex[0..7]
    auth_password = SecureRandom.hex[0..3]
    code = SecureRandom.hex[0..3]
    render :json => { uuid: uuid, password: auth_password, code: code }
  end

  collection_action :batch_new, title: "批量新增设备码", method: :get do
    render 'admin/device_uuids/batch_new'
  end

  collection_action :batch_create, method: :post do
    unless params[:device_uuid][:supplier_id].blank?
      if params[:device_uuid][:category_id].blank?
        flash.now[:message] = "请选择类别"
        render action: :batch_new and return
      elsif params[:device_uuid][:product_id].blank?
        flash.now[:message] = "请选择产品"
        render action: :batch_new and return
      elsif params[:device_uuid][:protocol].blank?
        flash.now[:message] = "请选择所用协议"
        render action: :batch_new and return
      elsif params[:device_uuid][:total_num].blank?
        flash.now[:message] = "请选择新增数量"
        render action: :batch_new and return
      else
        params[:device_uuid][:total_num].to_i.times do
          du = DeviceUuid.new(:supplier_id => params[:device_uuid][:supplier_id], :category_id => params[:device_uuid][:category_id], :product_id => params[:device_uuid][:product_id], :protocol => params[:device_uuid][:protocol])
          du.uuid = SecureRandom.hex[0..7]
          du.auth_password = SecureRandom.hex[0..3]
          du.code = SecureRandom.hex[0..3]
          if du.valid?
            du.save
            sleep 0.01
          end
        end
        flash[:notice] = "批量新增成功"
        redirect_to action: :index
      end
    else
      flash.now[:message] = "请选择厂家"
      render action: :batch_new
    end
  end

  sidebar "批量新增", :only => [:index] do
    link_to "批量新增设备码", batch_new_admin_device_uuids_path
  end

end