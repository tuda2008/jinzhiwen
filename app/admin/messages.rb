ActiveAdmin.register Message do

  actions :index, :show

  scope("全部A") { |message| message.all }
  scope("可见消息Y") { |message| message.visible }
  scope("不可见消息N") { |message| message.invisible }

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

end