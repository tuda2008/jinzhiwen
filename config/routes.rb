Rails.application.routes.draw do
  mount Redactor2Rails::Engine => '/redactor2_rails'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :api do
  	namespace :v1 do
  	  get 'users/wechat_auth', to: 'users#wechat_auth'
  	  get 'users/info', to: 'users#info'
    	post 'users/update_wechat_userinfo', to: 'users#update_wechat_userinfo' 
  	  resources :devices, only: [:index, :show]
  	  post 'devices/bind', to: 'devices#bind'
  	  post 'devices/unbind', to: 'devices#unbind'
      post 'devices/cmd', to: 'devices#cmd'
      post 'devices/rename', to: 'devices#rename'
      post 'devices/users', to: 'devices#users'
  	  resources :messages, only: [:index, :show]
      resources :app_versions, only: [:index, :show]
  	end
  end
  #post 'user_token' => 'user_token#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end