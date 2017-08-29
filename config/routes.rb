Rails.application.routes.draw do
  devise_for :users

  resources :shops, only: [:index, :show]

  devise_for :admins,
    path: 'admin',
    controllers: { sessions: 'admin/sessions' },
    only: :session
  namespace :admin do
    get :dashboard
    resources :shops
  end
end
