ActiveAdmin.register DeviceUuid do
  permit_params :supplier_id, :category_id, :product_id, :protocol, :uuid, :auth_password, :code

  menu priority: 5, label: proc{ I18n.t("activerecord.models.device_uuid") }

  filter :supplier_id, as: :select, collection: Supplier.all.pluck(:name, :id)
  filter :category_id, as: :select, collection: Category.all.pluck(:title, :id)
  filter :product_id, as: :select, collection: Product.all.pluck(:title, :id)
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
      row :actived_at
      row :created_at
    end
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :supplier_id, :as => :select, :collection => Supplier.visible.pluck(:name, :id)
      f.input :category_id, :as => :select, :collection => Category.visible.pluck(:title, :id)
      f.input :product_id, :as => :select, :collection => Product.visible.pluck(:title, :id)
      f.input :protocol, :as => :select, :collection => DeviceUuid::PROTOCOL_COLLECTION
      f.input :uuid, :hint => "设备唯一编号", :input_html => { :value => resource.uuid.present? ? resource.uuid : SecureRandom.hex[0..7], :readonly => true }
      f.input :auth_password, :as => :string, :hint => "设备验证码", :input_html => { :value => resource.auth_password.present? ? resource.auth_password : SecureRandom.hex[0..3], :readonly => true }
      f.input :code, :hint => "设备通讯码", :input_html => { :value => resource.code.present? ? resource.code : SecureRandom.hex[0..3], :readonly => true }
    end
    f.actions
  end

end