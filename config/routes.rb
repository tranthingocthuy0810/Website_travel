Rails.application.routes.draw do
  root to: 'static_pages#home'
  get "home", to: "static_pages#home", as: :home_client
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", registrations: "users/registrations", :confirmations => "users/confirmations"}
  get '/help', to: 'static_pages#help'
  get '/list_tour', to: 'static_pages#list_tour', as: 'list_tour'
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy' 
    get '/users/sign_in' => 'devise/sessions#new' 
  end

  namespace :admin do
    concern :paginatable do
      get '(page/:page)', action: :index, on: :collection, as: ''
    end
    get "home", to: "home#home_admin", as: :home_admin
    resource :users
    resources :tours, concerns: :paginatable
    resources :categories
    resources :list_tours    
  end

  resources :static_pages, only: %i(index show) do
    collection do
      get :show_recommendations
    end
  end
  resources :bookings do
    resource :checkout, only: [:new, :create], controller: 'checkouts'
    get 'success', on: :collection, to: 'bookings#success'
  end
  resource :webhooks, only: [:create]
end

