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
    get "/" => "homes#top"
    get "/customers" => "customers#index"
    get "/customers/:id" => "customers#show", as: 'show'
    get "/customers/:id/edit" => "customers#edit", as: 'edit'
    patch "/customers/:id" => "customers#update", as: 'update'
    get "/orders/:id" => "orders#show", as: 'orders'
    resources :items

  end

  scope module: :public do
    root to: 'homes#top'
    get '/home/about' => "homes#about", as: 'about'
    get 'customers/my_page' => 'customers#show'
    get 'customers/information/edit' => 'customers#edit'
    patch 'customers/information' => 'customers#update'
    get 'customers/unsubscribed' => 'customers#unsubscribed'
    patch 'customers/withdraw' => 'customers#withdraw'
    post 'orders/confirm' => 'orders#confirm'
    get 'orders/completion' => 'orders#completion'
    resources :orders, only: [:new, :create, :index, :show]
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :cart_items, only: [:index, :update, :create, :destroy]
    resources :items, only: [:index, :show]
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
