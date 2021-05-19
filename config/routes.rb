require 'sidekiq/web'

Rails.application.routes.draw do

  # Resource routing.
  resources :permissions, only: [:index, :update]
  resources :reviews
  resources :attachments
  resources :comments
  namespace :as400 do
    resources :shop_orders do
      member do
        post  :refresh_trico_labels
        post  :print_trico_labels
      end
    end
  end
  namespace :quality do
    resources :reject_tags do
      member do
        get :shop_order_partial_tag
      end
    end
  end
  namespace :shipping do
    resources :receiving_priority_notes, except: [:edit, :show]
  end

  # Devise routes for Google authentication.
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    get 'users/sign_in',  to: 'users/sessions#new',     as: :new_user_session
    get 'users/sign_out', to: 'users/sessions#destroy', as: :destroy_user_session
  end

  # Non resource routing.
  root  to: "pages#home"
  namespace :quality do
    get "reject_tags/sources_for/:shop_order",    to: "reject_tags#source_options_for_shop_order"
    get "reject_tags/tag_number_for/:shop_order", to: "reject_tags#tag_number_for_shop_order"
  end
  namespace :vcms do
    get "shipping/labeling_instructions", to: "shipping#labeling_instructions", as: :shipping_labeling_instructions
    get "shipping/promise_list",          to: "shipping#promise_list",          as: :shipping_promise_list
    get "production/jobs_on_receipt",     to: "production#jobs_on_receipt",     as: :production_jobs_on_receipt
    get "production/part_search",         to: "production#part_search",         as: :production_part_search
    get "sales/recent_customers",         to: "sales#recent_customers",         as: :sales_recent_customers
  end
  namespace :opto do
    post "log_trico_load",  to: "opto#log_trico_load"
  end
  get "shipping/trico_labels",  to: "shipping#trico_labels",  as: :trico_labels

  # Mount Sidekiq.
  mount Sidekiq::Web => "/sidekiq"
  get "/reset_sidekiq", to: "pages#reset_sidekiq_stats"

  # Set up ActionCable for live updates.
  mount ActionCable.server => '/cable'

end