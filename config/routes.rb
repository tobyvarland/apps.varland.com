Rails.application.routes.draw do

  # Resource routing.
  resources :permissions, only: [:index, :update]
  resources :reviews
  resources :attachments
  resources :comments
  namespace :as400 do
    resources :customers
    resources :parts
    resources :shop_orders
  end

  # Devise routes for Google authentication.
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    get 'users/sign_in',  to: 'users/sessions#new',     as: :new_user_session
    get 'users/sign_out', to: 'users/sessions#destroy', as: :destroy_user_session
  end

  # Non resource routing.
  root  to: "pages#home"

end