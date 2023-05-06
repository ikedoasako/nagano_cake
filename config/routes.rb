Rails.application.routes.draw do
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  namespace :admin do
    get "/admin" => "homes#top"
    get "admin/customers" => "customers#index"
    get "admin/customers/:id" => "customers#show"
    get "admin/customers/:id/edit" => "customers#edit"
    get "admin/customers/:id" => "customers#update"
    get "admin/orders/:id" => "orders#show"
    resources :items
  end

  scope module: :public do
    root to: 'homes#top'
    get "/home/about" => "homes#about", as: "about"
    get "customers/my_page" => "customers#show"
    get "customers/information/edit" => "customers#edit"
    patch "customers/information" => "customers#update"
    get "customers/unsubscribed" => "customers#unsubscribed"
    get "customers/withdraw" => "customers#withdraw"
    resources :orders, only: [:new, :create, :index, :show]
    get "orders/confirm" => "orders#confirm"
    get "orders/completion" => "orders#completion"
    resources :cart_items, only: [:index, :update, :create, :destroy]
    delete 'cart_items/destroy_all'
    resources :items, only: [:index, :show]
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
