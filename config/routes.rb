Rails.application.routes.draw do

  # 会員用：新規登録とログインのみ
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用：ログインのみ
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  # ゲストユーザー用
  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'customers/sessions#guest_sign_in'
  end

  #会員用
  scope module: :public do
    root :to => "homes#top"
    get "about" => "homes#about"

    resources :customers, only:[:show,:edit,:update]
      get "customers/:id/favorites" => "customers#favorites",as: :favorites
      get "customers/:id/unsubscribe" => "customers#unsubscribe",as: :unsubscribe
      patch "customers/:id/withdraw" => "customers#withdraw",as: :withdraw

    resources :recipes do
      resource :favorites, only:[:create,:destroy]
      resource :reports, only:[:create,:destroy]
      resources :comments, only:[:create,:destroy]
      collection do
        get "search_tag"
        get "search"
      end
    end

    resource :inquiries, only:[:new,:create]
      post "inquiries/confirm" => "inquiries#confirm",as: :confirm
  end

  #管理者用
  namespace :admin do
    root :to => 'homes#top'
    resources :recipes, only:[:index,:show,:destroy] do
      resources :comments, only:[:destroy]
    end
    resources :customers, only:[:show,:edit,:update]
    get "customers/:id/customer_recipes" => "customers#customer_recipes",as: :customer_recipes
    resources :tags,only:[:index,:create,:destroy,:edit,:update]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
