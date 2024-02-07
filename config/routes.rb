Spree::Core::Engine.routes.draw do
  resources :variant_quotation_requests, only: [:create, :index, :edit, :update]
  namespace :admin do
    resources :variant_quotation_requests do
      member do
        get :send_quotation_accepted_email
      end
    end
  end
  resources :orders, only: :create
end
