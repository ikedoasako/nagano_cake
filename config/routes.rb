Rails.application.routes.draw do
  namespace :admin do
    get 'orders/show'
    get 'customers/index'
    get 'customers/show'
    get 'customers/edit'
    get 'items/index'
    get 'items/new'
    get 'items/show'
    get 'items/edit'
    get 'homes/top'
  end

  scope module: :public do
    get 'orders/new'
    get 'orders/index'
    get 'orders/show'
    get 'cart_items/index'
    get 'customers/show'
    get 'customers/edit'
    root to: 'homes#top'
    get 'homes/about'
    get 'items/index'
    get 'items/show'
  end
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

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
