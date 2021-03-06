Rails.application.routes.draw do
  root 'reservations#index'

  namespace :shop_page do
    root 'reservations#index'
    get :request_agreement
    patch :agree
    resources :reservations, shallow: true do
      post :confirm, on: :collection
      patch :cancel, on: :member
      resources :payments, only: [:new, :create]
    end
  end

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

  # 本登録同時実施の際のユーザー登録
  resource :user, path: 'user/member', as: 'member_user', only: [:new, :create]

  get '/mypage', to: 'reservations#index'

  resources :shops, only: [:index, :show], shallow: true do
    resources :reservations, except: [:new] do
      post :confirm, on: :collection
      patch :cancel, on: :member
    end
  end

  # resources :reservation, only: [], shallow: true do
  #   resources :enquetes, only: [:new, :create]
  # end
  resources :subscriptions, only: [:new, :create] do
    get :description, on: :collection
  end
  resources :exchanges, only: [:new, :create, :show] do
    patch :reapply, on: :member
  end

  resources :reservation_payments, only: [:show, :update] do
    patch :registed_card, on: :member
  end
  namespace :api do
    resources :cities, only: [:index]
  end

  devise_for :admins,
    path: 'admin',
    controllers: { sessions: 'admin/sessions' },
    only: :session
  namespace :admin do
    get :dashboard
    resources :shops do
      member do
        get :edit_landscapes
        patch :landscapes
      end
    end
    resources :shop_landscapes, only: :destroy
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
    resources :subscriptions do
      patch :cancel, on: :member
      patch :restart, on: :member
    end
    resources :reservation_benefits do
      patch :done, on: :member
      patch :remand, on: :member
    end
    resources :exchanges do
      patch :done, on: :member
      patch :remand, on: :member
    end
    resources :reservation_payments
    resources :system_settings, only: [:index, :update]
  end
  get 'inquiry', to: 'statics#inquiry'
  get 'thanks', to: 'statics#thanks'
end
