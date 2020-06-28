Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  get 'bootstrap/index'
  root 'pages#home'

  # 廠商
  resources :vendors, except: [:show]

  # 產品名單
  resources :product_lists, except: [:show]
  
  # 客戶
  resources :customers, except: [:show]

  # 金價設定
  resources :price_boards

  # 產品
  resources :products do
    member do
      put :add_to_cart
      put :decrease_to_cart
      put :delete_to_cart
    end
  end

  # 回收金屬
  resources :scraps

  # 銷售
  resources :sales do
    member do
      post 'add', to: 'sales#add'
      post 'decrease', to: 'sales#decrease'
      post 'remove', to: 'sales#remove'
    end
  end

end
