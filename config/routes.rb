Rails.application.routes.draw do
  get 'home/index'
  post 'auth/register', to: 'users#register'
  post 'auth/login', to: 'users#login'
  get 'auth/test', to: 'users#test'
  resources :users, only: %i[update show] do
    resources :portfolios
  end

  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
