Rails.application.routes.draw do
  mount Redactor2Rails::Engine => '/redactor2_rails'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  scope '/api/v1' do
  	get 'users/wechat_auth'
  	get 'users/info'
  	post 'users/update_wechat_userinfo'
	resources :devices, only: [:index, :show]
	post 'devices/bind'
	post 'devices/unbind'
	resources :messages, only: [:index, :show]
    resources :app_versions, only: [:index, :show]
  end
  #post 'user_token' => 'user_token#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end