require 'sidekiq/web'

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    # registrations: 'users/registrations',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations',
    invitations: 'users/invitations'
  }
  devise_for :admins, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :admin do
    authenticate :admin do
      mount Sidekiq::Web => '/sidekiq'
    end
  end

  namespace :user, path: '/' do
    get :dashboard, to: 'dashboard#index'
    get :profile, to: 'profile#index'
    patch :profile, to: 'profile#update'
    patch :update_email, to: 'profile#update_email'
    patch :update_password, to: 'profile#update_password'
  end

  # public
  get :logged_out, to: 'home#logged_out'

  root "home#index"
end
