# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  namespace 'api' do
    resources :category
  end

  namespace 'admin' do
    resource :profile
  end

  scope module: 'web' do
    root 'home_page#home'
    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    resources :category
  end
end
