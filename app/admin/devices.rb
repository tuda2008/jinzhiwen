ActiveAdmin.register Device do
  actions :index, :show

  filter :device_status  
  filter :alias
  filter :wifi_mac
  filter :monitor_sn
  filter :port
  filter :created_at

end