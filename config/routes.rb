require 'sidekiq/web'

Rails.application.routes.draw do

  namespace :quality do
    namespace :calibration do
      resources :reason_codes, except: [:show]
    end
  end
  resources :employee_note_subjects
  resources :employee_notes do
    member do
      post  :add_attachment
    end
    collection do
      post  :import
    end
  end
  resources :shift_notes do
    member do
      post  :add_attachment
    end
    collection do
      post  :import
    end
  end
  namespace :quality do
    resources :hardness_tests do
      collection do
        get :deleted
      end
      member do
        post  :restore
      end
    end
  end
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
    post  :print_smalog_labels
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
    get "production/part_history_search", to: "production#part_history_search", as: :production_part_history_search
    get "sales/quote_search",             to: "sales#quote_search",             as: :sales_quote_search
    get "sales/recent_customers",         to: "sales#recent_customers",         as: :sales_recent_customers
    get "production/dept_5_recipes",      to: "production#dept_5_recipes",      as: :production_dept_5_recipes
    get "quality/final_inspect",          to: "quality#final_inspect",          as: :quality_final_inspect
  end
  namespace :opto do
    post "log_trico_load",  to: "opto#log_trico_load"
  end
  get "shipping/trico_labels",      to: "shipping#trico_labels",        as: :trico_labels
  get "shipping/smalog_labels",     to: "shipping#smalog_labels",       as: :smalog_labels
  get "vcms/link_part_spec",        to: "vcms#link_part_spec",          as: :link_part_spec
  get "vcms/record_final_inspect",  to: "vcms#record_final_inspect",    as: :record_final_inspect

  # Mount Sidekiq.
  mount Sidekiq::Web => "/sidekiq"
  get "/reset_sidekiq", to: "pages#reset_sidekiq_stats"

  # Set up ActionCable for live updates.
  mount ActionCable.server => '/cable'

end