Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  get 'bootstrap/index'
  root 'pages#home'

  # 廠商
  resources :vendors, except: [:show]

  # 產品名單
  resources :product_lists, except: [:show]
end
