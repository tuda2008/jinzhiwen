ActiveAdmin.register Device do
  actions :index, :show

  filter :device_status  
  filter :alias
  filter :imei
  filter :created_at

end