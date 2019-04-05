ActiveAdmin.register Device do
  actions :index, :show

  filter :device_status  
  filter :alias
  filter :imei
  filter :created_at

  index do
    selectable_column
      id_column
      column :device_uuid
      column :device_status
      column :alias
      column :imei
      column :users do |device|
      	device.users.map(&:name).join(',')
      end
      column :created_at
    actions
  end

  show do
  	attributes_table do
      row :id
      row :device_uuid
      row :device_status
      row :alias
      row :imei
      row :users do |device|
      	device.users.map(&:name).join(',')
      end
      row :invitors do |device|
      	device.invitors.map(&:name).join(',')
      end
      row :created_at
    end
  end

end