Rails.application.routes.draw do
  mount Redactor2Rails::Engine => '/redactor2_rails'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  #post 'user_token' => 'user_token#create'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end