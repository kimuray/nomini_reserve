Rails.application.routes.draw do
  get 'exchanges/new'

  root 'reservations#index'

  # deviseルーティングより前に置かないと優先度で負けるため先に記載
  resource :shops, only: [:edit, :update]

  devise_for :shops, controllers: {
    sessions: 'shops/sessions',
    registrations: 'shops/registrations',
    confirmations: 'shops/confirmations'
  }

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    omniauth_callbacks: 'users/omniauth_callbacks',
    confirmations: 'users/confirmations'
  }

  devise_scope :user do
    get 'users/edit/password', to: 'users/registrations#password_edit'
    patch 'users/edit/password', to: 'users/registrations#password_update'
    resource :bank_account, only: [:new, :create, :edit, :update]
    resource :introduction, only: [:new, :create]
  end

  get  '/mypage',    to: 'reservations#index'

  resources :shops, only: [:index, :show], shallow: true do
    resources :reservations, only: [:index, :show, :create, :confirm, :cancel] do
      post :confirm, on: :collection
      patch :cancel, on: :member
    end
  end

  resources :reservation, only: [], shallow: true do
    resources :enquetes, only: [:new, :create]
  end
  resources :payments, only: [:new, :create]
  resources :exchanges, only: [:new, :create, :show] do
    patch :reapply, on: :member
  end

  devise_for :admins,
    path: 'admin',
    controllers: { sessions: 'admin/sessions' },
    only: :session
  namespace :admin do
    get :dashboard
    resources :shops
    resources :reservation_categories
    resources :enquete_items
    resources :users
    resources :reservations do
      patch :done, on: :member
      patch :remand, on: :member
    end
    resources :enquetes, shallow: true do
      resources :enquete_answers, only: [:edit, :update, :destroy]
    end
    resources :payments do
      patch :cancel, on: :member
      patch :restart, on: :member
    end
    resources :exchanges do
      patch :done, on: :member
      patch :remand, on: :member
    end
  end
end
