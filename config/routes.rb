Rails.application.routes.draw do
  require 'sidekiq/web'

  # POST/api/v1/subscribe
  namespace :api do
    namespace :v1 do
      post 'subscribe', to: 'utils#subscribe'
      post 'transfer', to: 'utils#transfer'
      post 'get_price', to: 'utils#get_price'
    end
  end
  # devise_for :users, controllers: { sessions: "users/sessions" }

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: "users/sessions" }

  get 'bootstrap/index'
  # root 'pages#home'
  root 'pages#index'

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
  resources :scraps do
    member do
      put :add_to_cart
      put :decrease_to_cart
      put :delete_to_cart
    end
  end

  # 銷售
  resources :sales do
    member do
      post 'add', to: 'sales#add'
      post 'decrease', to: 'sales#decrease'
      post 'remove', to: 'sales#remove'
    end
  end

  # 提煉訂單
  resources :refine_orders do
    member do
      post 'add', to: 'refine_orders#add'
      post 'decrease', to: 'refine_orders#decrease'
      post 'remove', to: 'refine_orders#remove'
      get 'report', to: 'refine_orders#report'
    end  
  end

  resources :commodities, except: [:show] do
    member do
      post 'deal', to: 'commodities#deal'
    end
  end

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

end
