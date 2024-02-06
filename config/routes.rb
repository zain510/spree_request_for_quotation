Spree::Core::Engine.routes.draw do
  resources :variant_quotation_requests, only: [:create]
  namespace :admin do
    resources :variant_quotation_requests
  end
end
