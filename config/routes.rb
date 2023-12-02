Rails.application.routes.draw do
  root to: 'static_pages#home'
  get "home", to: "static_pages#home", as: :home_client
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", registrations: "users/registrations", :confirmations => "users/confirmations"}
  get '/help', to: 'static_pages#help'
  namespace :admin do
    resource :users
    resources :tours
    resources :categories
    resources :list_tours
    get "tours"
  end

  resources :static_pages, only: %i(index show)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
