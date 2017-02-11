Rails.application.routes.draw do
  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations',  }
  get '/splash' => 'splash#index'
  root 'splash#index'

  resources :alerts
end
