Rails.application.routes.draw do
  root to: 'static_pages#home'
  get "home", to: "static_pages#home", as: :home_client
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", registrations: "users/registrations", :confirmations => "users/confirmations"}
  get '/help', to: 'static_pages#help'
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy' 
  end

  namespace :admin do
    resource :users
    resources :tours
    resources :categories
    resources :list_tours
    get "tours"
  end

  resources :static_pages, only: %i(index show)

  resources :bookings do
    resource :checkout, only: [:new, :create], controller: 'checkouts' 
  end
end