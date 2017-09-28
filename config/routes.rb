Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    omniauth_callbacks: 'users/omniauth_callbacks',
    confirmations: 'users/confirmations'
  }
  get  '/mypage',    to: 'reservations#index'

  resources :shops, only: [:index, :show], shallow: true do
    resources :reservations do
      post :confirm, on: :collection
    end
  end
  resources :reservation, only: [], shallow: true do
    resources :enquetes, only: [:new, :create]
  end
  resources :payments, only: [:new, :create]

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
    resources :reservations
    resources :enquetes, shallow: true do
      resources :enquete_answers, only: [:edit, :update, :destroy]
    end
    resources :payments do
      patch :cancel, on: :member
      patch :restart, on: :member
    end
  end
end
