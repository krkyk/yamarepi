Rails.application.routes.draw do
  # 会員用：新規登録とログインのみ
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions'
  }

  # 管理者用：ログインのみ
  devise_for :admin, skip: %i[registrations passwords], controllers: {
    sessions: 'admin/sessions'
  }

  # ゲストユーザー用
  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'customers/sessions#guest_sign_in'
  end

  # 会員用
  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'
    get 'items/item_search' => 'items#item_search',as: :item_search

    resources :customers, only: %i[show edit update]
    get 'customers/:id/favorites' => 'customers#favorites', as: :favorites
    get 'customers/:id/my_forums' => 'customers#my_forums', as: :my_forums
    get 'customers/:id/unsubscribe' => 'customers#unsubscribe', as: :unsubscribe
    patch 'customers/:id/withdraw' => 'customers#withdraw', as: :withdraw

    resources :recipes do
      resource :favorites, only: %i[create destroy]
      resource :reports, only: %i[create destroy]
      resources :comments, only: %i[create destroy]
      collection do
        get 'search_tag'
        get 'search'
      end
    end

    resource :inquiries, only: %i[new create]
    post 'inquiries/confirm' => 'inquiries#confirm', as: :confirm

    resources :forums do
      resources :forum_comments, only: %i[create destroy]
      resource :attentions, only: %i[create destroy]
      resource :forum_reports, only: %i[create destroy]
    end
  end

  # 管理者用
  namespace :admin do
    root to: 'homes#top'
    resources :recipes, only: %i[index show destroy] do
      resources :comments, only: [:destroy]
    end
    resources :customers, only: %i[show edit update]
    get 'customers/:id/customer_recipes' => 'customers#customer_recipes', as: :customer_recipes
    resources :tags, only: %i[index create destroy edit update]
    resources :forums, only: %i[index show destroy] do
      resources :forum_comments, only: [:destroy]
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
