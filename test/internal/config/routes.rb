Rails.application.routes.draw do
  resources :orders
  root :to => 'orders#index'
end
